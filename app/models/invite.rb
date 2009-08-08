class Invite
  include DataMapper::Resource
  
  property :id, Serial
  belongs_to :user
  property :accepted, Boolean, :default=>false
  property :accepted_at, DateTime
  property :declined_at, DateTime
  property :name, Text, :nullable=>false
  
  before :save, :set_accepted
  before :valid?, :set_datetimes
  
  def set_datetimes
    self.accepted_at = nil if self.accepted_at.blank?
    self.declined_at = nil if self.declined_at.blank?
  end
  
  def set_accepted
    accepted = !accepted_at.nil?
  end
end
