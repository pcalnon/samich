class CreateJobQueues < ActiveRecord::Migration
  def change
    create_table :job_queues do |t|
      t.string :name
      t.string :description
      t.string :walltime_default
      t.string :walltime_minimum
      t.string :walltime_maximum
      t.string :memory_default
      t.string :memory_maximum
      t.string :cores_default
      t.string :cores_maximum

      t.timestamps
    end
  end
end
