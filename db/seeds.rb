# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


RoomType.create([{ name:  "Deluxe Rooms - Queen Size Bed"},
                 { name:  "Luxury Rooms - Queen Size Bed and Pool Facing"},
                 { name:  "Luxury Suites - King Size Bed and Pool Facing"},
                 { name:  "Presidential Suites - King Size Bed, Pool Facing with a Gym"}
                ])

Room.create([{ price: 100, room_type_id: 1, room_number:"A01" },
             { price: 100, room_type_id: 1, room_number:"A02" },
             { price: 100, room_type_id: 1, room_number:"A03" },
             { price: 100, room_type_id: 1, room_number:"A04" },
             { price: 100, room_type_id: 1, room_number:"A05" },

             { price: 100, room_type_id: 1, room_number:"B01" },
             { price: 100, room_type_id: 1, room_number:"B02" },
             { price: 100, room_type_id: 1, room_number:"B03" },
             { price: 100, room_type_id: 1, room_number:"B04" },
             { price: 100, room_type_id: 1, room_number:"B05" },

             { price: 100, room_type_id: 1, room_number:"C01" },
             { price: 100, room_type_id: 1, room_number:"C02" },
             { price: 100, room_type_id: 1, room_number:"C03" },
             { price: 100, room_type_id: 1, room_number:"C04" },
             { price: 100, room_type_id: 1, room_number:"C05" },

             { price: 100, room_type_id: 1, room_number:"D01" },
             { price: 100, room_type_id: 1, room_number:"D02" },
             { price: 100, room_type_id: 1, room_number:"D03" },
             { price: 100, room_type_id: 1, room_number:"D04" },
             { price: 100, room_type_id: 1, room_number:"D05" },

             { price: 150, room_type_id: 2, room_number:"A06" },
             { price: 150, room_type_id: 2, room_number:"A07" },
             { price: 150, room_type_id: 2, room_number:"A08" },
             { price: 150, room_type_id: 2, room_number:"A09" },
             { price: 150, room_type_id: 2, room_number:"A10" },

             { price: 150, room_type_id: 2, room_number:"B06" },
             { price: 150, room_type_id: 2, room_number:"B07" },
             { price: 150, room_type_id: 2, room_number:"B08" },
             { price: 150, room_type_id: 2, room_number:"B09" },
             { price: 150, room_type_id: 2, room_number:"B10" },

             { price: 150, room_type_id: 2, room_number:"C06" },
             { price: 150, room_type_id: 2, room_number:"C07" },
             { price: 150, room_type_id: 2, room_number:"C08" },
             { price: 150, room_type_id: 2, room_number:"C09" },
             { price: 150, room_type_id: 2, room_number:"C10" },

             { price: 150, room_type_id: 2, room_number:"D06" },
             { price: 150, room_type_id: 2, room_number:"D07" },
             { price: 150, room_type_id: 2, room_number:"D08" },
             { price: 150, room_type_id: 2, room_number:"D09" },
             { price: 150, room_type_id: 2, room_number:"D10" },

             { price: 175, room_type_id: 3, room_number:"D11" },
             { price: 175, room_type_id: 3, room_number:"D12" },
             { price: 175, room_type_id: 3, room_number:"D13" },
             { price: 175, room_type_id: 3, room_number:"D14" },
             { price: 175, room_type_id: 3, room_number:"D15" },
             { price: 175, room_type_id: 3, room_number:"D16" },
             { price: 175, room_type_id: 3, room_number:"D17" },
             { price: 175, room_type_id: 3, room_number:"D18" },
             { price: 175, room_type_id: 3, room_number:"D19" },
             { price: 175, room_type_id: 3, room_number:"D20" },

             { price: 175, room_type_id: 3, room_number:"E01" },
             { price: 175, room_type_id: 3, room_number:"E02" },

             { price: 175, room_type_id: 4, room_number:"E03" },
             { price: 200, room_type_id: 4, room_number:"E04" },
             { price: 200, room_type_id: 4, room_number:"E05" },
             { price: 200, room_type_id: 4, room_number:"E06" },
             { price: 200, room_type_id: 4, room_number:"E07" },
             { price: 200, room_type_id: 4, room_number:"E08" },
             { price: 200, room_type_id: 4, room_number:"E09" },
             { price: 200, room_type_id: 4, room_number:"E10" }])