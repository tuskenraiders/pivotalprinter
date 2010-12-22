$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'term/ansicolor'
require 'prawn'
require 'prawn/layout/grid'
require 'spruz/xt/full'
require 'trollop'
require 'yaml'
require "rubygems"
require "open-uri"
require "nokogiri"
require "pivotalprinter/client"
require "pivotalprinter/iteration"
require "pivotalprinter/story"

module Pivotalprinter
  VERSION = '0.1.2'
end

# Pivotalprinter::Client.token = '9676a31445151f492fa9ced2d86baadc'
# Pivotalprinter::Client.project_id = 45136
# 
# Pivotalprinter::Iteration.open('current')
# 
# Pivotalprinter::Iteration.open('backlog')
# 
# puts Pivotalprinter::Story.open(6707289).name
