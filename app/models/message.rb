class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
