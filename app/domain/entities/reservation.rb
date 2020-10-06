module Entities
  class Reservation < Dry::Struct
    transform_keys(&:to_sym)

    attribute :start_date, Types::Date
    attribute :end_date, Types::Date
    attribute :room_type, Types::String
    attribute :num_of_user, Types::Integer
    attribute :room_id, Types::Integer
    attribute :user_id, Types::Integer
  end
end