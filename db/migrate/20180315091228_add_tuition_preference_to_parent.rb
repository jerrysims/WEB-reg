class AddTuitionPreferenceToParent < ActiveRecord::Migration
  def change
    add_column :parents, :tuition_preference, :text
  end
end
