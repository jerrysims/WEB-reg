class RemoveTables < ActiveRecord::Migration[6.0]
  def up
    drop_table :student_shadows
    drop_table :shadow_spots
    drop_table :subjects
    drop_table :teachers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end