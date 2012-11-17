class User < ActiveRecord::Base
  has_and_belongs_to_many :rides
  validates :name, :presence => true

  def self.find_from_hash(hash)
    user = find_by_fb_id(hash['uid'])
    if user
      unless user.email
        user.email = hash[:info][:email]
        user.save
      end
    end
    user
  end

  def self.find_or_create_by_clef_id(response)
    puts response['info']
    if user = find_by_clef_id(response['info']['id'].to_s)
      user
    elsif user = find_by_email(response['info']['email'])
      user.clef_id = response['info']['id']
      user.save
    else
      user = create :name => (response['info']['first_name'] + " " + response['info']['last_name']),
                    :clef_id => response['info']['id'].to_s,
                    :email => response['info']['email'],
                    :fbimage => 'http://files.sharenator.com/awesome_face_151_U_WANT_CUTE-s580x580-92380-580.png'
    end
    user
  end

  def self.create_from_hash!(hash)
    user = create :name => hash['info'][:name], :fb_id => hash[:uid], :fbimage => hash['info'][:image], :fblink => hash['info'][:urls][:Facebook],:email => hash['info'][:email]
  end
end
