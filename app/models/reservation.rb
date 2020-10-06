class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, :start_date, :end_date, :room_id, presence: true

  ## Class methods
  class << self
    def reserved_rooms(start_date,end_date)
      booked_room = Reservation.where("start_date <= ? AND end_date >= ? ", end_date, start_date).collect(&:room_id)
      booked_room ? booked_room : []
    end
  end
end
