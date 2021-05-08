class CreateUserDailyComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_daily_comments do |t|
      t.integer       :user_id
      t.datetime      :created_comment_at
      t.string        :daily_comment
      t.timestamps
    end
  end
end
