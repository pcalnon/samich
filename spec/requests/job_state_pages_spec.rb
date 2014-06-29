require 'spec_helper'

describe "JobStatePages" do

  subject { page }

  describe "job state page" do

    let(:job_state) { FactoryGirl.create(:job_state) }
    before { visit job_state_path(job_state) }

    it { should have_content(job_state.job_id) }
    it { should have_content(job_state.user_id) }
    it { should have_content(job_state.queue_id) }
    it { should have_content(job_state.name) }
    it { should have_content(job_state.status) }
    it { should have_content(job_state.nodes_requested) }
    it { should have_content(job_state.cores_requested) }
    #it { should have_content(job_state.attribute_requested) }
    it { should have_content(job_state.memory_requested) }
    it { should have_content(job_state.walltime_requested) }
    #it { should have_content(job_state.submit_flags) }
    it { should have_content(job_state.node_list) }
    #it { should have_content(job_state.nodes_used) }
    #it { should have_content(job_state.cores_used) }
    #it { should have_content(job_state.memory_used) }
    #it { should have_content(job_state.walltime_used) }
    it { should have_content(job_state.submit_time) }
    #it { should have_content(job_state.start_time) }
    #it { should have_content(job_state.completion_time) }
    it { should have_title(job_state.job_id) }

  end

  describe "new job_state" do

    before { visit new_job_state_path }

    let(:submit) { "Job Status" }

    describe "with invalid information" do

      it "should not create a job state" do
        expect { click_button submit }.not_to change(Job, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Job Status') }
        it { should have_content('error') }
      end

    end

    describe "with valid information" do
      before do

        fill_in "Job",                 with: "5884110"
        fill_in "User",                with: "1"
        fill_in "Queue",               with: "1"
        fill_in "Name",                with: "STDIN"
        fill_in "Status",              with: "Running"

        fill_in "Nodes requested",     with: "1"
        fill_in "Cores requested",     with: "1"
        fill_in "Attribute requested", with: ":del_int_16_16"
        fill_in "Memory requested",    with: "100M"
        fill_in "Walltime requested",  with: "30:00:00"

        fill_in "Submit flags",        with: "-I"
        fill_in "Node list",           with: "n170/11"

        fill_in "Nodes used",          with: "1"
        fill_in "Cores used",          with: "1"
        fill_in "Memory used",         with: "100M"
        fill_in "Walltime used",       with: "00:04:29"

        fill_in "Submit time",         with: "Wed Jun 25 11:58:41 2014"

        fill_in "Start time",          with: "Wed Jun 25 11:58:42 2014"
        fill_in "Completion time",     with: "Wed Jun 25 12:03:11 2014"
      end

      it "should create a job state" do
        expect { click_button submit }.to change(JobState, :count).by(1)
      end

      describe "after saving the job state" do
        before { click_button submit }
        let(:job_state) {JobState.find_by(job_id: '5884110') }

        it { should have_title(job_state.job_id) }
        it { should have_selector('div.alert.alert-success', text: 'Congratulations') }
      end


    end

  end

end
