require 'rails_helper'

RSpec.describe "password_resets/new.html.erb", type: :view do
  subject { page }
  describe "new password reset page" do
    before { visit new_password_reset_path }

    it {  should have_content("Forgotten Password?") }

    describe "not present" do
      before { click_button "Reset Password" }
      it { should have_content("Please set your Email") }
    end
    describe "format email" do
      before do
        fill_in "Email", with: "test"
        click_button "Reset Password"
      end
      it { should have_content("Sorry!not email format") }
    end

  end
end
