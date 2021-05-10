class CreateDoneLists < ActiveRecord::Migration[6.0]
  def change
    create_table :done_lists do |t|
      t.integer       :daily_comment_id
      t.integer       :type_id
      t.string        :name
      t.float         :work_hours
      t.timestamps
    end
  end
end
