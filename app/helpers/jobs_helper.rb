module JobsHelper

  # submits the job to the cluster
  def submit_jobs(user, job_queue, job)

    ssh_cmd = "proxychains ssh pcalnon@login2.acf.ku.edu"

    qsub_cmd = "qsub -q " + job_queue.name
    if !( job.submit_flags.nil? || job.submit_flags.empty? )
      qsub_cmd_temp = qsub_cmd + " " + job.submit_flags
      qsub_cmd = qsub_cmd_temp
    end
    qsub_cmd_temp = qsub_cmd + " -l nodes=" + job.nodes_requested + ":ppn=" + job.cores_requested.to_s
    qsub_cmd = qsub_cmd_temp
    if !( job.attribute_requested.nil? || job.attribute_requested.empty? )
      qsub_cmd_temp = qsub_cmd + job.attribute_requested 
      qsub_cmd = qsub_cmd_temp
    end
    qsub_cmd_temp = qsub_cmd + ",mem=" + job.memory_requested + ",walltime=" + job.walltime_requested + " " + job.script

    submit_cmd = ssh_cmd + " \" " + qsub_cmd + " \" "

    #new_job = @job.new
    new_job  = IO.popen (submit_cmd)

  end
end


  # gets status information for jobs running on the cluster
  # TODO: need to do remote ssh connection with user.username 
  #       and add a jobs_scope = (single_user or all_users) flag
#  def submit_jobs(job, status, options = { user: nil })
#
#    proxy_cmd = "proxychains"
#    ssh_cmd = "ssh pcalnon@login2.acf.ku.edu"
#
#    if status.include?("running")
#      if user.nil?
#        qstat_cmd = "\"qstat -rtn \" "
#      else
#        qstat_cmd = "\"qstat -rtnu " + user.username + " \" "
#      end
#    elsif status.include?("idle")
#      if user.nil?
#        qstat_cmd = "\"qstat -it \" "
#      else
#        qstat_cmd = "\"qstat -itu " + user.username + " \" "
#      end
#    elsif status.include?("complete")
#      if user.nil?
#        qstat_cmd = "\"qstat -tn | grep \' C \'"
#      else
#        qstat_cmd = "\"qstat -tnu " + user.username + " | grep \' C \'"
#      end
#    elsif status.include?("error")
#      if user.nil?
#        qstat_cmd = "\"qstat -tn | grep \' E \'"
#      else
#        qstat_cmd = "\"qstat -tnu " + user.username + " | grep \' E \'"
#      end
#    end
#
#    if !( qstat_cmd.nil? || qstat_cmd.empty? )
#      remote_cmd = proxy_cmd + " " + ssh_cmd + " " + qstat_cmd
#      #job_list = IO.popen(remote_cmd)
#      IO.popen(remote_cmd) do |f|
#        f.each do |line|
#        puts line
#      end
#    end
#
#  end
#
#end
