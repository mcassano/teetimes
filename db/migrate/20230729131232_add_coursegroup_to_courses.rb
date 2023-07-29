class AddCoursegroupToCourses < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :coursegroup, null: false, foreign_key: true
  end
end
