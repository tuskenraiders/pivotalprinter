require 'open-uri'
require 'nokogiri'

module Pivotalprinter
  class Client
    class << self
      attr_accessor :token, :project

      def get(path, options={})
        raise TokenMissing if @token.nil?
        raise ProjectMissing if @project.nil?
        response = open("http://www.pivotaltracker.com/services/v3#{path}", 'X-TrackerToken' => @token, 'Content-Type' => 'application/xml').read
        Nokogiri::XML.parse(response)
      end
    end
  end
end
