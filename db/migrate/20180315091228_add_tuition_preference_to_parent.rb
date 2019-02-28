class AddTuitionPreferenceToParent < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :tuition_preference, :text
  end
end
