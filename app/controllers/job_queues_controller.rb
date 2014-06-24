class JobQueuesController < ApplicationController

  def show
    @job_queue = JobQueue.find(params[:id])
  end

  def new
  end

end
