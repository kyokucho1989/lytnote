class CreatePlanReviewLists < ActiveRecord::Migration[6.0]
  def change
    create_table :plan_review_lists do |t|
      t.integer       :plan_id
      t.integer        :review_id
      t.timestamps
    end
  end
end
