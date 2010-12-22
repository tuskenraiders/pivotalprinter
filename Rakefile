require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/pivotalprinter'

Hoe.plugin :newgem
Hoe.plugins.delete :rubyforge

Hoe.add_include_dirs "./lib/pivotalprinter"

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'pivotalprinter' do
  self.developer 'pkw.dev', 'dev@pkw.de'
  self.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  self.rubyforge_name       = self.name # TODO this is default value
  self.extra_deps         = [
    ['term-ansicolor','>= 0.4.4'],
    ['prawn','>= 0.8.4'],
    ['spruz','~> 0.2.0'],
    ['trollop','>= 1.16.2'],
    ['nokogiri','>= 1.4.4']
  ]
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]
