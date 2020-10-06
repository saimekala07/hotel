class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :price
      t.string :room_number
      t.belongs_to :room_type, foreign_key: true

      t.timestamps
    end
  end
end
