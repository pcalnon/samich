class AddIndexToJobQueueName < ActiveRecord::Migration
  def change
    add_index :job_queues, :name, unique: true
  end
end
