class CreateDoneLists < ActiveRecord::Migration[6.0]
  def change
    create_table :done_lists do |t|
      t.string :content
      t.references :user_daily_comment, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.float :work_hours

      t.timestamps
    end
  end
end
