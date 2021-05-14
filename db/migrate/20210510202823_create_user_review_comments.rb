class CreateUserReviewComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_review_comments do |t|
      t.integer       :user_id
      t.datetime      :created_on
      t.string        :comment
      t.timestamps
    end
  end
end
