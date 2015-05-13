require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /static_pages/home" do
    it "works! (now write some real specs)" do
      get static_pages_home_path
      expect(response).to have_http_status(200)
    end
  end
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
  end
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
  end
  describe "About page" do
    it "should have the content 'About'" do
      visit '/static_pages/about'
      expect(page).to have_content('About')
    end
  end
  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end
  end

  describe "title" do
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title('Home')
    end
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title('Help')
    end
    it "should have the title 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title('About')
    end
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title('Contact')
    end
  end
end
