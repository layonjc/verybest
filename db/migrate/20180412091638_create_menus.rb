class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :dish_id
      t.integer :venue_id

      t.timestamps

    end
  end
end
