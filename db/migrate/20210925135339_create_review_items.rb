class CreateReviewItems < ActiveRecord::Migration[6.0]
  def change
    create_table :review_items do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      t.string :copied_plan_name
      t.datetime :copied_plan_deadline
      t.string :copied_plan_status
      t.datetime :deadline_after_review
      t.string :status_after_review
      

      t.timestamps
    end
  end
end
