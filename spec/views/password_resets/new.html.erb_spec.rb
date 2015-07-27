require 'rails_helper'

RSpec.describe "password_resets/new.html.erb", type: :view do
  subject { page }
  describe "new password reset page" do
    before { visit new_password_reset_path }
    it {  should have_content("Forgotten Password?") }

  end
end
