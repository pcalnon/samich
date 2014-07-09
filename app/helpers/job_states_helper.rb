module JobStatesHelper


  def find_jobs(status, options = { user: nil })

    proxy_cmd = "proxychains"
    ssh_cmd = "ssh pcalnon@login2.acf.ku.edu"

    if status.include?("running")
      if user.nil?
        qstat_cmd = "\"qstat -rtn \" "
      else
        qstat_cmd = "\"qstat -rtnu " + user.username + " \" "
      end
    elsif status.include?("idle")
      if user.nil?
        qstat_cmd = "\"qstat -it \" "
      else
        qstat_cmd = "\"qstat -itu " + user.username + " \" "
      end
    elsif status.include?("complete")
      if user.nil?
        qstat_cmd = "\"qstat -tn | grep \' C \'"
      else
        qstat_cmd = "\"qstat -tnu " + user.username + " | grep \' C \'"
      end
    elsif status.include?("error")
      if user.nil?
        qstat_cmd = "\"qstat -tn | grep \' E \'"
      else
        qstat_cmd = "\"qstat -tnu " + user.username + " | grep \' E \'"
      end
    else
      # what?
    end

    if !( qstat_cmd.nil? || qstat_cmd.empty? )
      remote_cmd = proxy_cmd + " " + ssh_cmd + " " + qstat_cmd
      #job_list = IO.popen(remote_cmd)
      IO.popen(remote_cmd) do |f|
        f.each do |line|
          puts line
        end
      end

    end

    #IO.popen(submit_cmd) do |f|
    #  f.each do |line|
    #  #    job_id = 
    #    #puts line
    #    output += line + "\n"
    #  end
    #end
    
  end

end
