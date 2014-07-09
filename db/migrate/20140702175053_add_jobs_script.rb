class AddJobsScript < ActiveRecord::Migration
  def change
    add_column :jobs, :script, :string
  end
end
