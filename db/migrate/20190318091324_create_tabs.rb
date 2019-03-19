class CreateTabs < ActiveRecord::Migration[5.2]
  def change
    create_table :tabs do |t|
      t.float :tab_total
      t.float :initial_amount_owed
      t.integer :owed_by_user_id
      t.integer :owed_to_user_id
      t.string :description

      t.timestamps
    end
  end
end
