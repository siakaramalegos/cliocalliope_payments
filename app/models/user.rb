class User < ActiveRecord::Base
  has_one :customer
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
      if auth['info']
         user.email = auth['info']['email'] || ""
      end
      Admin.notify_new_user(User.first, user).deliver_now
    end
  end

  # pull over the user avatar from Facebook
  def small_image
    "https://graph.facebook.com/#{self.uid}/picture?type=small"
  end
end
