class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :in_reply_to, class_name: "User"
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  scope :from_users_followed_by_including_replies, lambda{ |user| followed_by_including_replies(user) }

#  def self.from_users_followed_by(user)
#    followed_user_ids = user.followed_user_ids
#    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
#  end
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end

  def self.from_users_followed_by_including_replies(user)
    followed_user_ids = "SELECT followed_id FROM relationships where follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR in_reply_to = :user_id", user_id: user)
  end
end
