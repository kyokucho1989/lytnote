class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :created_on
      t.string :content

      t.timestamps
    end
  end
end
