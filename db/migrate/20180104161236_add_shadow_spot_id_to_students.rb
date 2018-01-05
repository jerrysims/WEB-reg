class AddShadowSpotIdToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :shadow_spot, foreign_key: true
  end
end
