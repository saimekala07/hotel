class Api::V1::ReservationsController < ActionController::Base
  before_action :authenticate_user!, only: [:index]

  def index
    @reservations = current_user.reservations
    render json: @reservations
  end

  def availabile_rooms
    @rooms = Room.joins(:room_type).where.not(id: Reservation.all.map(&:room_id)).select(:room_number, 'room_types.name')
    render json: @rooms
  end
end


