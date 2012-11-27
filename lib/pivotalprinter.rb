$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Pivotalprinter
  require 'rubygems'
  require 'pivotalprinter/version'
  require 'term/ansicolor'
  require 'prawn'
  require 'prawn/layout/grid'
  require 'tins/xt/full'
  require 'trollop'
  require 'yaml'
  require "open-uri"
  require "nokogiri"
  require "pivotalprinter/client"
  require "pivotalprinter/iteration"
  require "pivotalprinter/story"
end
