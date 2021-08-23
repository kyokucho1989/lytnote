class CreateUserReviewComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_review_comments do |t|
      t.string :review_comment, null:false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
