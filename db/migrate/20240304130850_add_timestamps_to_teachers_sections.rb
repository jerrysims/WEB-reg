class AddTimestampsToTeachersSections < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :teachers_sections, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    change_column_default :teachers_sections, :created_at, from: -> { 'CURRENT_TIMESTAMP' }, to: nil
    change_column_default :teachers_sections, :updated_at, from: -> { 'CURRENT_TIMESTAMP' }, to: nil
  end
end
