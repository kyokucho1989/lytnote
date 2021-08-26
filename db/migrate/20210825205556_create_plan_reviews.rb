class CreatePlanReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :plan_reviews do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
