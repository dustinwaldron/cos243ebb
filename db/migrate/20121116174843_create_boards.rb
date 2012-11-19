class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.integer :user_id
      t.integer :height
      t.integer :width
      t.string :timezone

      t.timestamps
    end
  end
end
