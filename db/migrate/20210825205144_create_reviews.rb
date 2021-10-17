class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :content, null: false
      t.references :user, null: false, foreign_key: true
      t.datetime :reviewed_on, null: false

      t.timestamps
    end
  end
end
