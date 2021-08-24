class CreatePlanReviewLists < ActiveRecord::Migration[6.0]
  def change
    create_table :plan_review_lists do |t|
      t.references :plan_list, null: false, foreign_key: true
      t.references :user_review_comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
