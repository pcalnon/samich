require 'spec_helper'

describe JobState do

  before do
    @job_state = JobState.new(job_id: "5884110", user_id: 1, queue_id: 1, name: "STDIN", status: "Running", nodes_requested: "1", cores_requested: 1, attribute_requested: ":del_int_16_64", memory_requested: "2024M", walltime_requested: "10:00:00", submit_flags: "-I", node_list: "n091/17", nodes_used: "1", cores_used: "1", memory_used: "100m", walltime_used: "10:00:00", submit_time: "Tue Jun 24 11:30:54") 
  end

  subject { @job_state }

  it { should respond_to(:job_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:queue_id) }
  it { should respond_to(:name) }
  it { should respond_to(:status) }
  it { should respond_to(:nodes_requested) }
  it { should respond_to(:cores_requested) }
  it { should respond_to(:attribute_requested) }
  it { should respond_to(:memory_requested) }
  it { should respond_to(:walltime_requested) }
  it { should respond_to(:submit_flags) }
  it { should respond_to(:node_list) }
  it { should respond_to(:nodes_used) }
  it { should respond_to(:cores_used) }
  it { should respond_to(:memory_used) }
  it { should respond_to(:walltime_used) }
  it { should respond_to(:submit_time) }
  it { should respond_to(:start_time) }
  it { should respond_to(:completion_time) }


  it { should be_valid }

  describe "when job_id is not present" do
    before { @job_state.job_id = " " }
    it { should_not be_valid }
  end

#  describe "when job_id is already in use" do
#    before do
#      job_with_same_id = @job.dup
#      job_with_same_id.job_id = @job.job_id
#      job_with_same_id.save
#    end
#    it { should_not be_valid }
#  end
#  iFoo


  describe "when user_id is not present" do
    before { @job_state.user_id = " " }
    it { should_not be_valid }
  end

  describe "when queue_id is not present" do
    before { @job_state.queue_id = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @job_state.name = " " }
    it { should_not be_valid }
  end

  describe "when status is not present" do
    before { @job_state.status = " " }
    it { should_not be_valid }
  end

  describe "when nodes_requested is not present" do
    before { @job_state.nodes_requested = " " }
    it { should_not be_valid }
  end

  describe "when cores_requested is not present" do
    before { @job_state.cores_requested = " " }
    it { should_not be_valid }
  end

  describe "when memory_requested is not present" do
    before { @job_state.memory_requested = " " }
    it { should_not be_valid }
  end

  describe "when walltime_requested is not present" do
    before { @job_state.walltime_requested = " " }
    it { should_not be_valid }
  end

  describe "when node_list is not present" do
    before { @job_state.node_list = " " }
    it { should_not be_valid }
  end

  describe "when submit_time is not present" do
    before { @job_state.submit_time = " " }
    it { should_not be_valid }
  end

end
