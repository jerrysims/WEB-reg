class CreateCoursesProducts < ActiveRecord::Migration
  def change
    create_table :courses_products do |t|
      t.belongs_to :course
      t.belongs_to :product
    end
  end
end
