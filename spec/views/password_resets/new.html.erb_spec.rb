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

    describe "not email" do
      before do
        fill_in "Email", with: "test"
        click_button "Reset Password"
      end
      it { should have_content("Sorry!not email format") }
    end

    describe "format email" do
      before do
        fill_in "Email", with: "test@test.com"
        click_button "Reset Password"
      end
      it { should have_content("Email sent with password reset instructions.") }
    end

  end
end
