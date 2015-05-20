require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit root_path
      expect(page).to have_content('Sample App')
    end
  end
  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end
  end
  describe "About page" do
    it "should have the content 'About'" do
      visit about_path
      expect(page).to have_content('About')
    end
  end
  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end
  end

  describe "title" do
    it "should have the title 'Home'" do
      visit root_path
      expect(page).not_to have_title('Home')
    end
    it "should have the title 'Help'" do
      visit help_path
      expect(page).to have_title('Help')
    end
    it "should have the title 'About'" do
      visit about_path
      expect(page).to have_title('About')
    end
    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title('Contact')
    end
  end
end
