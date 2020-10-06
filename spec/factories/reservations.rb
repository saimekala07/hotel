FactoryBot.define do
  factory :reservation do
    start_date { Date.today }
    end_date { Date.today.next_day }
    room_type { "Deluxe Rooms - Queen Size Bed" }
    num_of_user { 3 }
    user_id { 1 }
    room_id { 1 }
  end
end
