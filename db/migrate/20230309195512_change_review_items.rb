class ChangeReviewItems < ActiveRecord::Migration[6.0]
  def up
    change_column_null :review_items, :plan_id, true
  end

  def down
    change_column_null :review_items, :plan_id, false
  end
end
