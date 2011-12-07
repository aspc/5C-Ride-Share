class User < ActiveRecord::Base
  has_and_belongs_to_many :rides
  
  def self.find_from_hash(hash)
    find_by_fb_id(hash['uid'])
  end
  
  def self.create_from_hash!(hash)
    user = create :name => hash[:info][:name], :fb_id => hash[:uid], :fbimage => hash[:info][:image], :fblink => hash[:info][:urls][:Facebook]
  end
end
