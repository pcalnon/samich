module JobsHelper

  # TODO: need to do remote ssh connection with user.username 
  #       and add a jobs_scope = (single_user or all_users) flag
  #       for vnc: /tools/cluster/6.2/glogin/glogin
         
  # submits the job to the cluster
  def submit_jobs(user, job_queue, job)
    ssh_cmd = "proxychains ssh pcalnon@login2.acf.ku.edu"
    qsub_cmd = "qsub -q " + job_queue.name + " -N " + job.name
    if !( job.submit_flags.nil? || job.submit_flags.empty? )
      qsub_cmd += " " + job.submit_flags
    end
    qsub_cmd += " -l nodes=" + job.nodes_requested + ":ppn=" + job.cores_requested.to_s
    if !( job.attribute_requested.nil? || job.attribute_requested.empty? )
      qsub_cmd += job.attribute_requested 
    end
    qsub_cmd += "\,mem=" + job.memory_requested + "\,walltime=" + job.walltime_requested + " " + job.script
    submit_cmd = ssh_cmd + " \" " + qsub_cmd + " \" "
    new_job_out  = IO.popen (submit_cmd)
    new_job = qsub_cmd + " | " + new_job_out.read
  end

  # retrieves qstat info for the job from cluster
  def get_job_info(job)
    ssh_cmd = "proxychains ssh pcalnon@login2.acf.ku.edu"
    qstat_cmd = "qstat -f " + job.job_id
    submit_cmd = ssh_cmd + " \" " + qstat_cmd + " \" "
    job_info  = IO.popen (submit_cmd)
  end
end

