class JobsController < ApplicationController

  def index
    @jobs = Job.all
    #@jobs = Job.find(params[:user_id])
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job_user = current_user
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    user = current_user
    @job.user_id = user.id

    if ( @job.queue_id.nil? || @job.queue_id.empty? )
      job_queue = JobQueue.find_by( name: "default" )
      @job.queue_id = job_queue.id
    else
      job_queue = JobQueue.find(@job.queue_id)
    end

    if ( @job.name.nil? || @job.name.empty? )
      @job.name = user.username + "_" + job_queue.name + "_" + Time.now.strftime( "%Y%m%d-%H:%M:%S" )
    end

    if ( @job.nodes_requested.nil? || @job.nodes_requested.empty? )
      @job.nodes_requested = "1"
    end

    if ( @job.cores_requested.nil? || @job.cores_requested.empty? )
      @job.cores_requested = job_queue.cores_default
    end
    if ( @job.walltime_requested.nil? || @job.walltime_requested.empty? )
      @job.walltime_requested = job_queue.walltime_default
    end
    if ( @job.memory_requested.nil? || @job.memory_requested.empty? )
      @job.memory_requested = job_queue.memory_default
    end

    new_job_out = view_context.submit_jobs(user, job_queue, @job)

    @job.submit_time = Time.now 
    @job.qsub_command = new_job_out.split('|').first
    @job.job_id = new_job_out.split('|').last.split(' ').last.split('.').first

    @job.qstat_info = view_context.get_job_info( @job ).read

    if @job.save
      flash[:success] = "Congratulations!  You successfully submitted a new cluster job. Take another bite of the Samich!"
      redirect_to @job
    else
      render 'new'
    end
  end

  private
    def job_params
      params.require(:job).permit(:job_id, :user_id, :queue_id, :name, :nodes_requested, :cores_requested, :attribute_requested, :memory_requested, :walltime_requested, :submit_flags, :submit_time, :script)
    end

end
