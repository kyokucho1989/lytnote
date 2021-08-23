class CreateUserDailyComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_daily_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :daily_comment, null: false

      t.timestamps
    end
  end
end
