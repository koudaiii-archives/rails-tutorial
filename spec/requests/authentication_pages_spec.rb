require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do
  describe "Authentication" do
    subject { page }
    before { visit signin_path }

    describe "signin" do

      describe "signin page" do
        it { should have_content('Sign in') }
        it { should have_title('Sign in') }
      end

      describe "with invalid signin" do
        before { click_button "Sign in" }
        it { should have_title('Sign in') }
        it { should have_error_message('Invalid') }

        describe "after visiting another page" do
          before { click_link "Home" }
          it { should_not have_selector('div.alert.alert-error') }
        end
      end

      describe "with valid signin" do
        let(:user){ FactoryGirl.create(:user) }
        before { valid_signin(user) }

        it { should have_title(user.name) }
        it { should have_link("Profile", href: user_path(user)) }
        it { should have_link("Sign out", href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }
        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end
    end

    describe "authorization" do
      let(:user){ FactoryGirl.create(:user) }

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end
        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
      describe "as wrong user" do
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
        before { sign_in user, no_capybara: true }

        describe "submitting a GET request to the Users#edit action" do
          before { get edit_user_path(wrong_user) }
          specify { expect(response.body).not_to match(full_title('Edit user')) }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe "submitting a PATCH request to the Users#update action" do
          before { patch user_path(wrong_user) }
          specify { expect(response).to redirect_to(root_path) }
        end
      end
      describe "for non-signed-in users" do
        it { should_not have_link('Users',    href: users_path) }
        it { should_not have_link('Profile',  href: user_path(user)) }
        it { should_not have_link('Settings', href: edit_user_path(user)) }
        it { should_not have_link('Sign out', href: signout_path) }
        it { should have_link('Sign in', href: signin_path) }

        describe "when attempting to visit a protected page" do
          before do
            visit edit_user_path(user)
            sign_in user
          end

          describe "after signing in" do
            it "should render the desired protected page" do
              expect(page).to have_title('Edit user')
            end

            describe "when signing in again" do
              before do
                delete signout_path
                sign_in user
              end

              it "should render the default(profile) page" do
                expect(page).to have_title(user.name)
              end
            end
          end
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
      end
      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before { sign_in user }

        it { should have_title(user.name) }
        it { should have_link('Users',    href: users_path) }
        it { should have_link('Profile',  href: user_path(user)) }
        it { should have_link('Settings', href: edit_user_path(user)) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }
      end
      describe "as an non-admin user" do
        let(:user){ FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { sign_in non_admin, no_capybara: true }

        describe "submitting a DELETE request to the User#destoroy action" do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(root_path) }
        end
      end

      describe "should be not able to delete own user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before { sign_in admin, no_capybara: true }
        it "not to change user" do
          expect { delete user_path(admin) }.not_to change(User, :count)
        end
      end

      describe "redirect to root path" do
        let(:user){ FactoryGirl.create(:user) }
        before { sign_in user, no_capybara: true }

        describe "access new_user_path" do
          before { get new_user_path }
          specify { expect(response).to redirect_to(root_path) }
        end
        describe "access new_user_path" do
          let(:params) do
            { user: { name: user.name, email: user.email, password: user.password, password_confirmation: user.password } }
          end
          before { post users_path(user), params }
          specify { expect(response).to redirect_to(root_path) }
        end
      end
    end
  end
end
