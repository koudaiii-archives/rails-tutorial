require 'rails_helper'

RSpec.describe "UserEditPages", type: :request do
  describe "User edit pages" do
    subject { page }
    before do
      visit signin_path
      valid_signin(user)
    end
    let(:user){ FactoryGirl.create(:user) }

    describe "edit" do
      before { visit edit_user_path(user) }

      describe "page" do
        it { should have_content("Update your profile") }
        it { should have_title("Edit user") }
        it { should have_link('change', href: 'http://gravatar.com/emails') }
      end

      describe "with invalid information" do
        before { click_button "Save changes" }

        it { sohuld have_content('error') }
      end
    end
  end
end
