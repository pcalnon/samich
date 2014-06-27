class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string  :job_id
      t.integer :user_id
      t.integer :queue_id
      t.string  :name
      t.string  :nodes_requested
      t.integer :cores_requested
      t.string  :attribute_requested
      t.string  :memory_requested
      t.string  :walltime_requested
      t.string  :submit_flags
      t.string  :node_list
      t.string  :nodes_used
      t.integer :cores_used
      t.string  :memory_used
      t.string  :walltime_used
      t.string  :submit_time
      t.string  :start_time
      t.string  :completion_time

      t.timestamps
    end
  end
end
