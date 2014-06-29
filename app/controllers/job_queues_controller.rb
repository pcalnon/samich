class JobQueuesController < ApplicationController

  def show
    @job_queue = JobQueue.find(params[:id])
  end

  def new
    @job_queue = JobQueue.new
  end

  def create
    @job_queue = JobQueue.new(job_queue_params)
    if @job_queue.save
      flash[:success] = "Congratulations, you have created a new Job Queue! Take another bite of the Samich!"
      redirect_to @job_queue
    else
      render 'new'
    end
  end

  def edit
    @job_queue = JobQueue.find(params[:id])
  end

  def update
    @job_queue = JobQueue.find(params[:id])
    if @job_queue.update_attributes(job_queue_params)
      # Handle a successful update.
      flash[:success] = "Thank you for updating the job queue.  Take another bite of the Samich!"
      redirect_to @job_queue
    else
      render 'edit'
    end
  end

  private
    def job_queue_params
      params.require(:job_queue).permit(:name, :description, :walltime_default, :walltime_minimum, :walltime_maximum, :memory_default, :memory_maximum, :cores_default, :cores_maximum)
    end

end
