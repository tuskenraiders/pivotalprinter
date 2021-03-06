require 'trollop'
require 'yaml'
require 'prawn'
require 'prawn/layout/grid'
'optparse'
module Pivotalprinter
  class Printer
    def run(argv)
      @argv = argv.dup
      opts = parse_options
      yaml = load_yaml_config
      project, token = extract_config(opts, yaml)
      Pivotalprinter::Client.project = project
      Pivotalprinter::Client.token   = token
      @project_name = (Client.get("/projects/#{project}") / 'project/name').text
      @stories =
        case @argv.last
        when "done"    then Pivotalprinter::Iteration.open('done').stories
        when "backlog" then Pivotalprinter::Iteration.open('backlog').stories
        when /\A\d+\z/ then Pivotalprinter::Story.open(@argv.map(&:to_i))
        else                Pivotalprinter::Iteration.open('current').stories
        end
      generate_output
    rescue ConfigNeeded
      print_config
    rescue TokenMissing
      Trollop::die :token, "token must be specified through config file or explicitly"
    rescue ProjectMissing
      Trollop::die :project, "project must be a valid number or one of the configured projects (#{(yaml.keys - ["default"]).join(", ")}) if no default is configured in $HOME/.pivotalprinterrc"
    rescue Exception
      puts "[!] There was an error while generating the PDF file... What happened was:".white.on_red
      raise
    end

    def print_config
      puts <<CONFIG
---
default: &default
  token:   "YOUR TOKEN HERE"
  project: 123

some_project:
  <<:      *default # so you don't need to rewrite the token
  project: 789
CONFIG
    end

    def parse_options
      opts = Trollop::options(@argv) do
        version "pivotalprinter #{Pivotalprinter::VERSION} (c) 2010#{(year = Time.now.year) > 2010 ? "-#{year}" : ''} pkw.de"
        banner <<-EOS
Pivotalprinter is an awesome program to print stories from the PivotalTracker.

Usage:
        pivotalprinter [-p PROJECT] [-t TOKEN] [current|backlog|done|STORY]
        pivotalprinter --config > ~/.pivotalprinterrc

Options:
EOS
        opt :project,  "Project Name defined in $HOME/.pivotalprinterrc or project number",
          :short => "-p", :type => :string
        opt :token,    "Pivotaltracker Token",       :short => "-t", :type => :string
        opt :config,   "show example configuration", :short => "-c"
      end

      raise ConfigNeeded if opts[:config]
      opts
    end

    def load_yaml_config
      File.exist?("#{ENV["HOME"]}/.pivotalprinterrc") ? YAML::load_file("#{ENV["HOME"]}/.pivotalprinterrc") : {}
    end

    def extract_config(opts, yaml)
      if opts[:project].nil? && yaml.key?("default")
        return yaml["default"]["project"], yaml["default"]["token"]
      elsif opts[:project] =~ /[0-9]+/
        return opts[:project], (opts[:token] || yaml["default"]["project"])
      elsif yaml.key?(opts[:project])
        return yaml[opts[:project]]["project"], yaml[opts[:project]]["token"]
      else
        raise ProjectMissing
      end
    end

    def generate_output
      Prawn::Document.generate("/tmp/stories.pdf", :page_layout => :landscape, :margin => [25, 25, 50, 25], :page_size   => 'A4') do |pdf|
        @num_cards_on_page = 0
        pdf.font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"
        @stories.each_with_index do |story, i|
          # --- Split pages
          if i > 0 and i % 4 == 0
            # puts "New page..."
            pdf.start_new_page
            @num_cards_on_page  = 1
          else
            @num_cards_on_page += 1
          end

          # --- Define 2x2 grid
          pdf.define_grid(:columns => 2, :rows => 2, :gutter => 42)
          # pdf.grid.show_all

          row    = (@num_cards_on_page + 1) / 4
          column = i % 2
          padding = 12
          cell = pdf.grid( row, column )
          cell.bounding_box do
            pdf.stroke_color = "666666"
            pdf.stroke_bounds

            pdf.text_box "#@project_name ##{story.id}", :size => 10, :overflow => :truncate,
              :width => cell.width - ( padding * 2),
              :at => [pdf.bounds.left + padding, pdf.bounds.top - padding / 2 ]

            pdf.text_box story.name, :size => 14, :height => 50, :overflow => :truncate,
              :width => cell.width - (padding * 2) - 100,
              :at => [pdf.bounds.left + padding + 50, pdf.bounds.top - 2 * padding]

            pdf.text_box story.description.strip, :size => 8, :overflow => :truncate,
              :width => cell.width - ( padding * 2), :height => cell.height - (padding * 8),
              :at => [pdf.bounds.left + padding, pdf.bounds.top - 2 * padding - 55]

            pdf.text_box "Created at: #{story.created_at.strftime('%F')}", :size => 8,
              :at => [pdf.bounds.left + padding, pdf.bounds.bottom + padding]

            pdf.text_box "State: #{story.current_state}", :size => 8,
              :at => [pdf.bounds.left + 120, pdf.bounds.bottom + padding]

            pdf.text_box "Requester: #{story.requested_by}", :size => 8,
              :at => [pdf.bounds.left + 200, pdf.bounds.bottom + padding]

            x, y = 32, 205 - padding
            pdf.fill_color story.points_background
            pdf.fill_circle [x, y], 25
            pdf.font_size = 36
            pdf.font "Helvetica", :style => :bold
            pdf.fill_color 'ffffff'
            pdf.draw_text "#{story.points}", :at => [x - (story.points.to_s.to_i >= 10 ? 20 : 10), y - 12]
            pdf.fill_color '000000'
            pdf.font_size = 14
            pdf.font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf", :style => :normal
            pdf.image open("#{File.dirname(__FILE__)}/images/#{story.story_type}.png"), :position => cell.width - 51, :vposition => 5 + padding
          end
        end
      end
      puts ">>> Generated PDF file in 'stories.pdf' with #{@stories.size} stories".black.on_green
      system "open /tmp/stories.pdf"
    end
  end
end
