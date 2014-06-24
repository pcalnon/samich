require 'spec_helper'

describe JobQueue do

  before do
    @job_queue = JobQueue.new(name: "foo", description: "The foo queue is where jobs go to die.", walltime_default: "03:00:00:00", walltime_minimum: "00:00:00:01", walltime_maximum: "07:00:00:00", memory_default: "2000M", memory_maximum: "132G", cores_default: "1", cores_maximum: "20")
  end

  subject { @job_queue }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:walltime_default) }
  it { should respond_to(:walltime_minimum) }
  it { should respond_to(:walltime_maximum) }
  it { should respond_to(:memory_default) }
  it { should respond_to(:memory_maximum) }
  it { should respond_to(:cores_default) }
  it { should respond_to(:cores_maximum) }

  it { should be_valid }

  describe "when name is not present" do
    before { @job_queue.name = " " }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      job_queue_with_same_name = @job_queue.dup
      job_queue_with_same_name.name = @job_queue.name.upcase
      job_queue_with_same_name.save
    end

    it { should_not be_valid }
  end


#  describe "when description is not present" do
#    before { @job_queue.description = " " }
#    it { should_not be_valid }
#  end

  describe "when walltime_default is not present" do
    before { @job_queue.walltime_default = " " }
    it { should_not be_valid }
  end

#  describe "when walltime_minimum is not present" do
#    before { @job_queue.walltime_minimum = " " }
#    it { should_not be_valid }
#  end
#
#  describe "when walltime_maximum is not present" do
#    before { @job_queue.walltime_maximum = " " }
#    it { should_not be_valid }
#  end

  describe "when memory_default is not present" do
    before { @job_queue.memory_default = " " }
    it { should_not be_valid }
  end

  describe "when memory_maximum is not present" do
    before { @job_queue.memory_maximum = " " }
    it { should_not be_valid }
  end

  describe "when cores_default is not present" do
    before { @job_queue.cores_default = " " }
    it { should_not be_valid }
  end

  describe "when cores_maximum is not present" do
    before { @job_queue.cores_maximum = " " }
    it { should_not be_valid }
  end

end
