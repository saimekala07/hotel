module Validators
  module Reservation
    class ReservationContract < ::Dry::Validation::Contract

      params do
        required(:start_date).filled(:date)
        required(:end_date).maybe(:date)
        required(:room_type).filled(:string)
        required(:num_of_user).filled(:integer)
        optional(:room_id).maybe(:string)
        optional(:user_id).maybe(:string)
      end

      rule(:start_date) do
        key.failure("Check In date can't be blank") if values[:start_date].blank?
        key.failure("Check In date not in valid format") unless values[:start_date].is_a?(Date)
        key.failure("Check In date must be Current date or Future Date") if values[:start_date].is_a?(Date) && values[:start_date] < Date.today
      end

      rule(:end_date, :start_date) do
        key.failure("Check Out date can't blank") if values[:end_date].blank?
        key.failure("Check Out date not in valid format") unless values[:end_date].is_a?(Date)
        key.failure("Check Out date must be after start date") if values[:end_date] < values[:start_date]
        key.failure("Check Out date can't exceed 6 months, date should be before #{Date.today + 6.months}") if Date.today + 6.months < values[:end_date]
      end

      rule(:room_type, :start_date, :end_date) do
        key.failure("#{values[:room_type]} Room not available for provided date") unless Room.available_rooms(values[:start_date], values[:end_date], values[:room_type]).present?
      end
    end
  end
end
