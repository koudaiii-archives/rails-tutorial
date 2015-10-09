# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  content      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = Message.new(sender_id: "1", recipient_id: "2", content: "Direct Message")
  end
  subject { @message }

  it { should respond_to(:sender_id) }
  it { should respond_to(:recipient_id) }
  it { should respond_to(:content) }
  it { should be_valid }
end
