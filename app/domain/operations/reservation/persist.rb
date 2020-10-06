require 'dry/monads'
require 'dry/monads/do'

module Operations
  module Reservation
    class Persist
      include Dry::Monads[:result, :do]

      def call(params:, user:)
        valid_params                = yield validate(params.to_h.symbolize_keys)   # validates params
        values                      = yield allocate_room(valid_params, user)      # allocates room to user
        entity                      = yield initialize_entity(values)              # initialize with neccessary fields to reserve
        reservation_success         = yield persist_data(entity, user)             # persist reservation
        Success(reservation_success)
      end

      private

      def validate(params)
        result = ::Validators::Reservation::ReservationContract.new.call(params)
        if result.success?
          Success(result)
        else
          errors = result.errors.to_h.values.flatten
          Failure([result, errors])
        end
      end

      def allocate_room(values, user)
        available_room = Room.available_rooms(values[:start_date], values[:end_date], values[:room_type]).limit(1).first
        Success(values.to_h.merge(room_id: available_room.id, user_id: user.id))
      end

      def initialize_entity(values)
        result = ::Entities::Reservation.new(values.to_h)
        Success(result)
      end

      def persist_data(entity, user)
        reservation = user.reservations.build(entity.to_h)
        reservation.save!
        Success(reservation)
      end
    end
  end
end

