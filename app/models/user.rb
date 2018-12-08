class User < ActiveRecord::Base
  has_many :rides_users
  has_many :rides, :through => :rides_users

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validate :is_password_necessary

  enum school: [ :unknown, :pomona, :claremont_mckenna, :harvey_mudd, :scripps, :pitzer ]

  def is_password_necessary
    return if is_cas_authenticated

    if password.blank?
      errors.add(:password, 'needs to be present if is_cas_authenticated is false')
    end
  end

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
    create :name => hash['info'][:name], :fb_id => hash[:uid], :fbimage => hash['info'][:image], :fblink => hash['info'][:urls][:Facebook],:email => hash['info'][:email]
  end
end
