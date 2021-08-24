class CreatePlanLists < ActiveRecord::Migration[6.0]
  def change
    create_table :plan_lists do |t|
      t.string :plan_name
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.datetime :deadline
      t.references :status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
