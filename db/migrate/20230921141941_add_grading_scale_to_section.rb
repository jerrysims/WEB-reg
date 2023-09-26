class AddGradingScaleToSection < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :grading_scale, :string
  end
end
