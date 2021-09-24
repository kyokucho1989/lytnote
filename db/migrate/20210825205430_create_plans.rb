class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.string :name
      t.datetime :set_on
      t.datetime :deadline
      t.string :status

      t.timestamps
    end
  end
end
