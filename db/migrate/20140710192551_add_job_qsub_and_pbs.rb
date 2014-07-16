class AddJobQsubAndPbs < ActiveRecord::Migration
  def change
    add_column :jobs, :qsub_command, :string
    add_column :jobs, :pbs_script, :string
  end
end
