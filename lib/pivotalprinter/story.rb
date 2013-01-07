require 'time'

module Pivotalprinter
  class Story
    FIELDS = [ :name, :id, :story_type, :estimate, :current_state, :description, :requested_by, :labels, :created_at, :updated_at ]
    attr_accessor(*FIELDS)

    def initialize(xml)
      FIELDS.each do |field|
        value = xml.css("#{field}")
        send "#{field}=", value.first.full? { |v| v.send(:text) } || value.send(:text)
      end
      created_at and self.created_at = Time.parse(created_at)
      updated_at and self.updated_at = Time.parse(updated_at)
    end

    def self.open(ids)
      ids.map do |id|
        response = Client.get "/projects/#{Client.project}/stories/#{id}"
        response = Nokogiri::XML.parse(response)
        self.new(response.css('story'))
      end
    end

    def points
      estimate.to_i >= 0 ? estimate.to_i : '?'
    end

    def points_background
      case points
        when '?' then 'cccccc'
        when  0  then 'ccff66'
        when  1  then '408000'
        when  2  then '808000'
        when  3  then 'ffcc66'
        when  5  then 'ff8000'
        when  8  then 'ff0000'
        else     'aa0000'
      end
    end

  end
end
