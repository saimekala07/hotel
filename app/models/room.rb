class Room < ApplicationRecord
  belongs_to :room_type

  ## Class methods
  class << self
    def available_rooms(start_date, end_date, room_type)
      reserved_rooms = Reservation.reserved_rooms(start_date, end_date)
      room_id = RoomType.find_by(name: room_type).id
      if reserved_rooms.present?
        self.where("room_type_id = ? AND id NOT IN (?)", room_id, reserved_rooms)
      else
        self.where("room_type_id = ?", room_id)
      end
    end
  end
end
