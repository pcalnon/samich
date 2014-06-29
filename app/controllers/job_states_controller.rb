class JobStatesController < ApplicationController

  def show
    #@job_state = JobState.find(params[:job_id])
    @job_state = JobState.find(params[:id])
  end

  def new
    @job_state = JobState.new
  end

  def create
    @job_state = JobState.new(job_state_params)
    if @job_state.save
      flash[:success] = "Congratulations, you updated the status of your job! Take another bite of the Samich!"
      redirect_to @job_state
    else
      render 'new'
    end
  end

  private
    def job_state_params
      params.require(:job_state).permit(:job_id, :user_id, :queue_id, :name, :status, :nodes_requested, :cores_requested, :attribute_requested, :memory_requested, :walltime_requested, :submit_flags, :node_list, :submit_time)
    end

end
