module JobsHelper

  # submits the job to the cluster
  def job_submit(job, user, job_queue)

    ssh_cmd = "proxychains ssh " + user.username + "@login2.acf.ku.edu"

    qsub_cmd = "qsub -q " + job_queue.name + " -l nodes=" + job.nodes_requested + ":ppn=" + job.cores_requested + job.attribute_requested + ",mem=" + job.memory_requested + ",walltime=" + job.walltime_requested + " " + job.executable

    submit_cmd = ssh_cmd + "\"" + qsub_cmd + "\""

    IO.popen (submit_cmd) do |f|

      f.each do |line|

  #      job_id = 
        puts line

      end

    end

  end
end
