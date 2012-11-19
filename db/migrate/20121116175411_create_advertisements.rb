class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :x_location
      t.integer :y_location
      t.integer :height
      t.integer :width
      t.integer :user_id
      t.integer :board_id
      t.binary :image

      t.timestamps
    end
  end
end
