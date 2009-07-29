class Invite
  include DataMapper::Resource
  
  property :id, Serial
  belongs_to :user
  property :accepted, DateTime
end
