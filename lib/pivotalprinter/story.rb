module Pivotalprinter
  class Story
    attr_accessor :name, :id, :story_type, :estimate, :current_state, :description, :requested_by, :labels
    
    def initialize(xml)
      [:name, :id, :story_type, :estimate, :current_state, :description, :requested_by, :labels].each do |field|
        send "#{field}=", xml.css(field.to_s).send(:text)
      end
    end
    
    def self.open(id)
      response = Client.get "/projects/#{Client.project}/stories/#{id}"
      response = Nokogiri::XML.parse(response)
      self.new(response.css('story'))
    end
    
    def points
      estimate.to_i >= 0 ? estimate.to_i : '?'
    end
    
    def points_background
      case points
        when '?': 'cccccc'
        when  0: 'ccff66'
        when  1: '408000'
        when  2: '808000'
        when  3: 'ffcc66'
        when  5: 'ff8000'
        when  8: 'ff0000'
        else     'aa0000'
      end
    end

  end
end