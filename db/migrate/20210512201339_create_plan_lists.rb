class CreatePlanLists < ActiveRecord::Migration[6.0]
  def change
    create_table :plan_lists do |t|
      t.integer       :user_id
      t.string        :plan_name
      t.integer       :type_id
      t.datetime      :created_on
      t.datetime      :updated_on
      t.datetime      :deadline
      t.integer       :status_id
      t.timestamps
    end
  end
end
