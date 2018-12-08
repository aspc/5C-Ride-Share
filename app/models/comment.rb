class Comment < ActiveRecord::Base
  belongs_to :ride
  belongs_to :user

  def get_user
    user = User.find_by(id: self.user_id)
    unless user.nil?
      return user.name
    end
    return ""
  end
end
