class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_ACCOUNTNAME_REGEX = /\A[a-z](\w*[a-z0-9])*\z/i

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :account_name, presence: true,
                          length: { maximum: 15 },
                          format: { with: VALID_ACCOUNTNAME_REGEX},
                          uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  has_many :messages, foreign_key: "sender_id", dependent: :destroy
  has_many :reverse_messages, foreign_key: "recipient_id", class_name: "Message", dependent: :destroy

  has_many :microposts, dependent: :destroy
  has_many :reply_to, through: :microposts, source: :in_reply_to
  has_many :followed_users, through: :relationships, source: :followed

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id",
                                  class_name: "Relationship",
                                  dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_followed_by_including_replies(self)
  end

  def feed_in_direct_messages
    Message.relation_direct_messages(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
