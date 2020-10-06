json.extract! reservation, :id, :start_date, :end_date, :room_type, :num_of_user, :user_id, :room_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
