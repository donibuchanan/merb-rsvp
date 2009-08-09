class Submission
  include DataMapper::Resource
  
  property :id, Serial
  property :content, String, :length=>(1..250), :message=>"please enter a few characters but not too many"
  property :formatted_content, Text
  property :type,  Enum[:video, :text, :image], :default=>:text
  property :display_counter, Integer, :default=>0
  belongs_to :user
  validates_is_unique :content, :message=>"This has already been submitted!"
  validates_with_method :check_valid_video
  
  before :save, :format_content
  
  def self.random(options={})
    limit = options[:count] || 1
    type = options[:type] || :text
    
    results = []
    limit.times do 
      results << all(:type=>type.to_sym).sort_by {rand}[0]
    end
    results
  end
  
  def format_content
    case self.type
      when :text
        self.formatted_content = content
      when :video
        self.formatted_content = UnvlogIt.new(content).embed_html(308, 250)
    end
  end
  
  def check_valid_video
    if self.type == :video
      begin
        UnvlogIt.new(self.content)
        return true
      rescue
        return [false, "Video is not a valid video link"]
      end
    else
      return true
    end
  end
  
end
