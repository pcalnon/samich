class JobsController < ApplicationController

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:success] = "Congratulations, you have created a new Job! Take another bite of the Samich!"
      redirect_to @job
    else
      render 'new'
    end
  end

  private
    def job_params
      params.require(:job).permit(:job_id, :user_id, :queue_id, :name, :nodes_requested, :cores_requested, :attribute_requested, :memory_requested, :walltime_requested, :submit_flags, :node_list, :submit_time)
    end

end
