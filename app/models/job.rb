class Job < ActiveRecord::Base
  validates(:job_id, presence: true, uniqueness: true)
  validates(:user_id, presence: true)
  validates(:queue_id, presence: true)
  validates(:name, presence: true)
  validates(:nodes_requested, presence: true)
  validates(:cores_requested, presence: true)
  validates(:memory_requested, presence: true)
  validates(:walltime_requested, presence: true)
  validates(:node_list, presence: true)
  validates(:submit_time, presence: true)
end
