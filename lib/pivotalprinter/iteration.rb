module Pivotalprinter
  class Iteration

    attr_accessor :stories

    def self.open(name)
      self.new(name)
    end

    def initialize(name)
      @stories = []
      extract_stories Client.get("/projects/#{Client.project}/iterations/#{name}")
    end

    private

    def extract_stories(response)
      response.css("story").each do |story|
        @stories << Story.new(story)
      end
    end
  end
end
