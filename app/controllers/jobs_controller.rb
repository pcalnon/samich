class JobsController < ApplicationController

  def index
    #get_jobs @jobs
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

    job_queue = JobQueue.find(@job.queue_id)

    if @job.walltime_requested.nil?
      @job.walltime_requested = job_queue.walltime_default
    end
    if @job.memory_requested.nil?
      @job.memory_requested = job_queue.memory_default
    end

    #@new_job = view_context.submit_jobs(user, job_queue, @job)
    #new_job_id_line = view_context.submit_jobs(user, job_queue, @job).read
    new_job_id = view_context.submit_jobs(user, job_queue, @job).read
    #new_job_id_line = new_job_id;


    #new_job_id_line.split do |f|
    new_job_id.split(' ') do |f|
      if f.include? "fusion"
        new_job_id = f.split('.').first
      end
    end


    #@job.job_id = @new_job.job_id
    @job.job_id = new_job_id


    @job.start_time = Time.now 

    if @job.save
      flash[:success] = "Congratulations, you have submitted a new Job! Take another bite of the Samich!"
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
