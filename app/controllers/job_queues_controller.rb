class JobQueuesController < ApplicationController

  def show
    @job_queue = JobQueue.find(params[:id])
  end

  def new
    @job_queue = JobQueue.new
  end

end
