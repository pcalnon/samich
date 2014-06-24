class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :job_id
      t.integer :user_id
      t.integer :queue_id
      t.string :name

      t.string :nodes_requested
      t.integer :cores_requested
      t.string :memory_requested
      t.datetime :walltime_requested

      t.string :submit_flags

      t.string :node_list

      t.string :nodes_used
      t.integer :cores_used
      t.string :memory_used
      t.datetime :walltime_used

      t.datetime :submit_time
      t.datetime :start_time
      t.datetime :completion_time

      t.timestamps
    end
  end
end
