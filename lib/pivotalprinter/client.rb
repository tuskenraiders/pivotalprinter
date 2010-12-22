module Pivotalprinter
  class Client
    class << self
      attr_accessor :token, :project

      def get(path, options={})
        raise TokenMissing if @token.nil?
        raise ProjectMissing if @project.nil?
        open("http://www.pivotaltracker.com/services/v3#{path}", 'X-TrackerToken' => @token, 'Content-Type' => 'application/xml').read
      end
    end
  end
end
