class CreateReportItems < ActiveRecord::Migration[6.0]
  def change
    create_table :report_items do |t|
      t.string :content, null: false
      t.references :report, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.float :work_hours, null: false

      t.timestamps
    end
  end
end
