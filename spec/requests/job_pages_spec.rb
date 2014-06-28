require 'spec_helper'

describe "Job pages" do

  subject { page }

  describe "job page" do

    let(:job) { FactoryGirl.create(:job) }
    before { visit job_path(job) }

    it { should have_content(job.job_id) }
    it { should have_content(job.user_id) }
    it { should have_content(job.queue_id) }
    it { should have_content(job.name) }
    it { should have_content(job.nodes_requested) }
    it { should have_content(job.cores_requested) }
    #it { should have_content(job.attribute_requested) }
    it { should have_content(job.memory_requested) }
    it { should have_content(job.walltime_requested) }
    #it { should have_content(job.submit_flags) }
    it { should have_content(job.node_list) }
    #it { should have_content(job.nodes_used) }
    #it { should have_content(job.cores_used) }
    #it { should have_content(job.memory_used) }
    #it { should have_content(job.walltime_used) }
    it { should have_content(job.submit_time) }
    #it { should have_content(job.start_time) }
    #it { should have_content(job.completion_time) }
    it { should have_title(job.job_id) }

  end

  describe "new job" do

    before { visit new_job_path }

    let(:submit) { "New Job" }

    describe "with invalid information" do

      it "should not create a job" do
        expect { click_button submit }.not_to change(Job, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Submit Job') }
        it { should have_content('error') }
      end

    end

    describe "with valid information" do
      before do

        fill_in "Job",                 with: "5884110"
        fill_in "User",                with: "1"
        fill_in "Queue",               with: "1"
        fill_in "Name",                with: "STDIN"

        fill_in "Nodes requested",     with: "1"
        fill_in "Cores requested",     with: "1"
        fill_in "Attribute requested", with: ""
        fill_in "Memory requested",    with: "100M"
        fill_in "Walltime requested",  with: "30:00:00"

        fill_in "Submit flags",        with: " "
        fill_in "Node list",           with: "n170/11"

        fill_in "Nodes used",          with: "1"
        fill_in "Cores used",          with: "1"
        fill_in "Memory used",         with: "100M"
        fill_in "Walltime used",       with: "00:04:29"

        fill_in "Submit time",         with: "Wed Jun 25 11:58:41 2014"

        fill_in "Start time",          with: "Wed Jun 25 11:58:42 2014"
        fill_in "Completion time",     with: "Wed Jun 25 12:03:11 2014"
      end

      it "should create a job" do
        expect { click_button submit }.to change(Job, :count).by(1)
      end

      describe "after saving the job" do
        before { click_button submit }
        let(:job) {Job.find_by(job_id: '5884110') }

        it { should have_title(job.job_id) }
        it { should have_selector('div.alert.alert-success', text: 'Congratulations') }
      end


    end

  end

end
