module JobStatesHelper


  #def find_jobs(status, options = { user: nil })
  def find_jobs(status, user)

    proxy_cmd = "proxychains"
    ssh_cmd = "ssh pcalnon@login2.acf.ku.edu"

    if status.include?("running")
      if user.nil?
        qstat_cmd = "qstat -rtn"
      else
        qstat_cmd = "qstat -rtnu " + user.username
      end
    elsif status.include?("idle")
      if user.nil?
        qstat_cmd = "qstat -it"
      else
        qstat_cmd = "qstat -itu " + user.username
      end
    elsif status.include?("complete")
      if user.nil?
        qstat_cmd = "qstat -tn | grep \' C \'"
      else
        qstat_cmd = "qstat -tnu " + user.username + " | grep \' C \'"
      end
    elsif status.include?("held")
      if user.nil?
        qstat_cmd = "qstat -tn | grep \' H \'"
      else
        qstat_cmd = "qstat -tnu " + user.username + " | grep \' H \'"
      end
    elsif status.include?("error")
      if user.nil?
        qstat_cmd = "qstat -tn | grep \' E \'"
      else
        qstat_cmd = "qstat -tnu " + user.username + " | grep \' E \'"
      end
    else
      # what?
    end

    if !( qstat_cmd.nil? || qstat_cmd.empty? )
      remote_cmd = proxy_cmd + " " + ssh_cmd + " \" " + qstat_cmd + " \" "
      current_jobs = IO.popen(remote_cmd)
      current_jobs_list = qstat_cmd + " ~|~ " + current_jobs.read
    end
    
  end

  def find_job_info( job_id )

    #@job = Job.find_by(job_id)
    @job_state = JobState.find_by( job_id: job_id )

  end

end
