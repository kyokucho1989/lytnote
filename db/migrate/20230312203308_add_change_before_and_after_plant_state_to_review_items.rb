class AddChangeBeforeAndAfterPlantStateToReviewItems < ActiveRecord::Migration[6.0]
  def change
    add_column :review_items, :before_plan_status, :string
    add_column :review_items, :after_plan_status, :string
  end
end
