class AddContentToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :qstat_info, :string
  end
end
