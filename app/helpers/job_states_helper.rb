module JobStatesHelper

# Returns the Gravatar (http://gravatar.com/) for the given user.
  #def find_jobs(user, options = { status: "running" } )
  def find_jobs(user, status)
    proxy_cmd = "proxychains"
    ssh_cmd = "ssh pcalnon@login2.acf.ku.edu"
    if status.include?("running")
      #qstat_cmd = "\"qstat -rtn\""
      qstat_cmd = "\"qstat -rtnu" + user.username + " \" "
    else 
      if status.include?("idle")
        #qstat_cmd = "\"qstat -it\""
        qstat_cmd = "\"qstat -itu" + user.username + " \" "
      end
    end
    if !( qstat_cmd.nil? || qstat_cmd.empty? )
      remote_cmd = proxy_cmd + " " + ssh_cmd + " " + qstat_cmd
      job_list = IO.popen(remote_cmd)
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
