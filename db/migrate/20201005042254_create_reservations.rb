class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.string :room_type
      t.integer :num_of_user
      t.belongs_to :user, foreign_key: true
      t.belongs_to :room, foreign_key: true

      t.timestamps
    end
  end
end
