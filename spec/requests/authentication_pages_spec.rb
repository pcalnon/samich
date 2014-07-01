require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end

    end

  end


  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user)      { FactoryGirl.create(:user) }
      let(:group)     { FactoryGirl.create(:group) }
      let(:job_queue) { FactoryGirl.create(:job_queue) }


      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Username", with: user.username
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit User')
          end
        end
      end


      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end

      end

      describe "in the Groups controller" do

        describe "visiting the edit page" do
          before { visit edit_group_path(group) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch group_path(group) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the group index" do
          before { visit groups_path }
          it { should have_title('Sign in') }
        end

      end


      describe "in the JobQueues controller" do

        describe "visiting the edit page" do
          before { visit edit_job_queue_path(job_queue) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch job_queue_path(job_queue) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the job queue index" do
          before { visit job_queues_path }
          it { should have_title('Sign in') }
        end

      end

    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, username: "wrongexample", email: "wrongexample@bogus.com") }
      #before { sign_in user, no_capybara: true }
      before { sign_in user }


      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit User')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end


      describe "submitting a GET request to the Groups#edit action" do
        before { get edit_group_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Update the Group')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Groups#update action" do
        before { patch group_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end


      describe "submitting a GET request to the JobQueues#edit action" do
        before { get edit_job_queue_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Update the Job Queue')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the JobQueues#update action" do
        before { patch job_queue_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end


    end

  end

end
