class Comment < ActiveRecord::Base
  belongs_to :ride

  def get_user
    user = User.find_by(id: self.user_id)
    unless user.nil?
      return user.name
    end
    return ""
  end
end
