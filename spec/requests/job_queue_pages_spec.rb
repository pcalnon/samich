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

end
