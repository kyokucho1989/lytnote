class CreatePlanReviewRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :plan_review_records do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      # t.references :genre, null: false, foreign_key: true
      t.string :name
      t.string :status
      t.datetime :deadline
      t.string :status_after_review
      t.datetime :deadline_after_review
      t.timestamps
    end
  end
end
