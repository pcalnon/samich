class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :primary_investigator
      t.string :department
      t.string :office
      t.string :phone

      t.timestamps
    end
  end
end
