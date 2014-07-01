require 'spec_helper'

describe "JobQueue pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:job_queue, name: "longer",  description: "for even longer jobs",            walltime_default: "200:00:00",  memory_default: "2000M", cores_default: "1")
      FactoryGirl.create(:job_queue, name: "longest", description: "for the longest of of the long",  walltime_default: "500:00:00",  memory_default: "2000M", cores_default: "1")
      FactoryGirl.create(:job_queue, name: "crazy",   description: "now you are just being crazy",    walltime_default: "1000:00:00", memory_default: "4000M", cores_default: "1")
      visit job_queues_path
    end

    it { should have_title('All Job Queues') }
    it { should have_content('All Job Queues') }

    it "should list each job queue" do
      JobQueue.all.each do |job_queue|
        expect(page).to have_selector('li', text: job_queue.name)
      end
    end
  end


  describe "job_queue profile page" do
    let(:job_queue) { FactoryGirl.create(:job_queue) }
    before { visit job_queue_path(job_queue) }

    it { should have_content(job_queue.name) }
    #it { should have_content(job_queue.description) }
    it { should have_content(job_queue.walltime_default) }
    #it { should have_content(job_queue.walltime_minimum) }
    #it { should have_content(job_queue.walltime_maximum) }
    it { should have_content(job_queue.memory_default) }
    #it { should have_content(job_queue.memory_maximum) }
    it { should have_content(job_queue.cores_default) }
    #it { should have_content(job_queue.cores_maximum) }

  end


  describe "new job queue" do

    before { visit new_job_queue_path }

    let(:submit) { "New Job Queue" }

    describe "with invalid information" do

      it "should not create a job queue" do
        expect { click_button submit }.not_to change(JobQueue, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('New Job Queue') }
        it { should have_content('error') }
      end

    end

    describe "with valid information" do
      before do

        fill_in "Name",                with: "long"
        fill_in "Description",         with: "Queue for long running jobs."
        fill_in "Walltime default",    with: "168:00:00"
        fill_in "Walltime minimum",    with: "168:00:00"
        fill_in "Walltime maximum",    with: " "

        fill_in "Memory maximum",      with: " "
        fill_in "Memory default",      with: "2000M"

        fill_in "Cores default",       with: "1"
        fill_in "Cores maximum",       with: " "
      end

      it "should create a job queue" do
        expect { click_button submit }.to change(JobQueue, :count).by(1)
      end

      describe "after saving the job queue" do
        before { click_button submit }
        let(:job_queue) {JobQueue.find_by(name: 'long') }

        it { should have_title(job_queue.name) }
        it { should have_selector('div.alert.alert-success', text: 'Congratulations') }
      end

    end

  end

  describe "edit job queue" do
    let(:job_queue) { FactoryGirl.create(:job_queue) }
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      #sign_in user, no_capybara: true 
      visit edit_job_queue_path(job_queue)
    end

    describe "page" do
      it { should have_content("Update the Job Queue") }
      it { should have_title("Edit Job Queue") }
    end

    describe "with invalid information" do
      let(:bogo_name)              { " " }
      let(:bogo_description)       { " " }
      let(:bogo_walltime_default)  { " " }
      let(:bogo_walltime_minimum)  { " " }
      let(:bogo_walltime_maximum)  { " " }
      let(:bogo_memory_maximum)    { " " }
      let(:bogo_memory_default)    { " " }
      let(:bogo_cores_default)     { " " }
      let(:bogo_cores_maximum)     { " " }
      before do
        fill_in "Name",                with: bogo_name
        fill_in "Description",         with: bogo_description
        fill_in "Walltime default",    with: bogo_walltime_default
        fill_in "Walltime minimum",    with: bogo_walltime_minimum
        fill_in "Walltime maximum",    with: bogo_walltime_maximum
        fill_in "Memory maximum",      with: bogo_memory_maximum
        fill_in "Memory default",      with: bogo_memory_default
        fill_in "Cores default",       with: bogo_cores_default
        fill_in "Cores maximum",       with: bogo_cores_maximum
        click_button "Save changes"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)              { "new_queue" }
      let(:new_description)       { "New Queue Description" }
      let(:new_walltime_default)  { "168:00:00" }
      let(:new_walltime_minimum)  { "100:00:00" }
      let(:new_walltime_maximum)  { "256:00:00" }
      let(:new_memory_maximum)    { "256G" }
      let(:new_memory_default)    { "2000M" }
      let(:new_cores_default)     { "1" }
      let(:new_cores_maximum)     { "20" }
      before do
        fill_in "Name",                with: new_name
        fill_in "Description",         with: new_description
        fill_in "Walltime default",    with: new_walltime_default
        fill_in "Walltime minimum",    with: new_walltime_minimum
        fill_in "Walltime maximum",    with: new_walltime_maximum
        fill_in "Memory maximum",      with: new_memory_maximum
        fill_in "Memory default",      with: new_memory_default
        fill_in "Cores default",       with: new_cores_default
        fill_in "Cores maximum",       with: new_cores_maximum
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      #it { should have_link('Sign out', href: signout_path) }
      specify { expect(job_queue.reload.name).to              eq new_name }
      specify { expect(job_queue.reload.description).to       eq new_description }
      specify { expect(job_queue.reload.walltime_default).to  eq new_walltime_default }
      specify { expect(job_queue.reload.walltime_minimum).to  eq new_walltime_minimum }
      specify { expect(job_queue.reload.walltime_maximum).to  eq new_walltime_maximum }
      specify { expect(job_queue.reload.memory_maximum).to    eq new_memory_maximum }
      specify { expect(job_queue.reload.memory_default).to    eq new_memory_default }
      specify { expect(job_queue.reload.cores_default).to     eq new_cores_default }
      specify { expect(job_queue.reload.cores_maximum).to     eq new_cores_maximum }
    end

  end


end
