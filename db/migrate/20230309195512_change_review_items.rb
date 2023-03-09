class ChangeReviewItems < ActiveRecord::Migration[6.0]
  def up
    change_column_null :review_items, :plan_id, true
    # 外部キーの参照先をnullにする
    
    ReviewItem.where.not(plan_id: nil).each do |review_item|
      review_item.update_column(:plan_id, nil)
    end

  end

  def down
    change_column_null :review_items, :plan_id, false
  end
end
