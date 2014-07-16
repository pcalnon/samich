class JobStatesController < ApplicationController
  before_action :signed_in_user, only: [:create, :edit, :update]


  def index
    user = current_user
    @job_running_out    = view_context.find_jobs("running" , user)
    @job_running_qstat  = @job_running_out.split('~|~').first
    @job_running_list   = @job_running_out.split('~|~').last

    @job_idle_out       = view_context.find_jobs("idle"    , user)
    @job_idle_qstat     = @job_idle_out.split('~|~').first
    @job_idle_list      = @job_idle_out.split('~|~').last

    @job_complete_out   = view_context.find_jobs("complete", user)
    @job_complete_qstat = @job_complete_out.split('~|~').first
    @job_complete_list  = @job_complete_out.split('~|~').last

    @job_held_out       = view_context.find_jobs("held"    , user)
    @job_held_qstat     = @job_held_out.split('~|~').first
    @job_held_list      = @job_held_out.split('~|~').last

    @job_error_out      = view_context.find_jobs("error"   , user)
    @job_error_qstat    = @job_error_out.split('~|~').first
    @job_error_list     = @job_error_out.split('~|~').last
  end

  def show
    @job_state = view_context.find_job_info( params[:job_id] )
    #@job_state = view_context.find_job_info( job_id )
    #@job_state = JobState.find_by(@job.job_id)
    #@job_state = JobState.find(params[:id])
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

    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in to the Samich." unless signed_in?
      end
    end

end
