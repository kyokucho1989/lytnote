class ChangeColumnToGenre < ActiveRecord::Migration[6.0]
  def change
    change_column_null :report_items, :genre_id, true
    change_column_default :report_items, :genre_id, from: nil, to: 0

    change_column_null :plans, :genre_id, true
    change_column_default :plans, :genre_id, from: nil, to: 0
  end
end
