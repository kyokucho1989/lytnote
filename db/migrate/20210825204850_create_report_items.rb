class CreateReportItems < ActiveRecord::Migration[6.0]
  def change
    create_table :report_items do |t|
      t.string :content
      t.references :report, null: false, foreign_key: true
      t.reference :genre
      t.float :work_hours

      t.timestamps
    end
  end
end
