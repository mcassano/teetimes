class CreateCoursegroups < ActiveRecord::Migration[7.0]
  def change
    create_table :coursegroups do |t|
      t.string :name

      t.timestamps
    end
  end
end
