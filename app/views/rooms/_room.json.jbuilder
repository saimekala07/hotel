json.extract! room, :id, :price, :room_number, :room_type_id, :created_at, :updated_at
json.url room_url(room, format: :json)
