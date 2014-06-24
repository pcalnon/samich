class AddIndexToJobsJobId < ActiveRecord::Migration
  def change
    add_index :jobs, :job_id, unique: true
  end
end
