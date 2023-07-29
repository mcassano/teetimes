class CreatePlaydates < ActiveRecord::Migration[7.0]
  def change
    create_table :playdates do |t|
      t.references :coursegroup, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :requested_date

      t.timestamps
    end
  end
end
