require 'spec_helper'

describe "JobQueue pages" do

  subject { page }

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

    end

  end

end
