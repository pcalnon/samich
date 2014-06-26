module JobsHelper

##class TorqueModule
#  def initialize(username)
#    @username = username
#  end
#  def submit_job
#    uname = @username
#    IO.popen ("proxychains ssh  pcalnon@login2.acf.ku.edu \"qsub -q default -l nodes=1:ppn=1,mem=1000M,walltime=10:00:00 /research/pcalnon/test.bash\"" do |f|
#      f.each do |line|
#        puts line
#      end
#    end
#  end
##end

# Returns the Gravatar (http://gravatar.com/) for the given user.
def job_submit(job, user, job_queue)
  ssh_cmd = "proxychains ssh " + user.username + "@login2.acf.ku.edu"
  qsub_cmd = "qsub -q " + job_queue.name + " -l nodes=" + job.nodes_requested + ":ppn=" + job.cores_requested + ",mem=" + 

  submit_cmd = 

  job_id = 

  image_tag(gravatar_url, alt: user.name, class: "gravatar")
end


end
