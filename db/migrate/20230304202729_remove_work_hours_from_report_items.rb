class RemoveWorkHoursFromReportItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :report_items, :work_hours, true
  end
end
