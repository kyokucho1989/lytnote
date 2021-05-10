class CreateUserReviewComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_review_comments do |t|

      t.timestamps
    end
  end
end
