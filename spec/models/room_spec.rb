require 'rails_helper'
require 'spec_helper'

RSpec.describe Room, :type => :model, :dbclean => :after_each do

  let(:user) { FactoryBot.create(:user) }
  let!(:dex_room_type)  { FactoryBot.create(:room_type, name: "Deluxe Rooms") }
  let!(:lux_room_type)  { FactoryBot.create(:room_type, name: "Luxury Rooms") }
  let!(:dex_room1)       { FactoryBot.create(:room, room_type: dex_room_type) }
  let!(:dex_room2)       { FactoryBot.create(:room, room_type: dex_room_type) }
  let!(:lux_room)       { FactoryBot.create(:room, room_type: lux_room_type) }
  let!(:reservation) { FactoryBot.create(:reservation, start_date: start_date, end_date: end_date, room: dex_room1, user: user) }
  let(:start_date)   { Date.today }
  let(:end_date)     { Date.today }

  describe "#available_rooms" do

    context "rooms available" do
      it "should return available dex_room" do
        expect( Room.available_rooms(start_date, end_date, dex_room_type.name)).to eq [dex_room2]
      end

      it "should return available lux_room" do
        expect( Room.available_rooms(start_date, end_date, lux_room_type.name)).to eq [lux_room]
      end
    end

    context "all rooms booked for a given day" do
      let!(:reservation2) { FactoryBot.create(:reservation, room: dex_room2, start_date: start_date, end_date: end_date, user: user) }
      let!(:reservation3) { FactoryBot.create(:reservation, room: lux_room, start_date: start_date, end_date: end_date, user: user) }

      it "should return empty array when all occupied for a date" do
        expect( Room.available_rooms(start_date, end_date, dex_room_type.name)).to eq []
        expect( Room.available_rooms(start_date, end_date, lux_room_type.name)).to eq []
      end
    end

    context "rooms should be available for next day" do
      let!(:reservation2) { FactoryBot.create(:reservation, room: dex_room2, start_date: start_date, end_date: end_date, user: user) }
      let!(:reservation3) { FactoryBot.create(:reservation, room: lux_room, start_date: start_date, end_date: end_date, user: user) }

      it "should return all available rooms" do
        expect( Room.available_rooms(start_date.next_day, end_date.next_day, dex_room_type.name)).to eq [dex_room1, dex_room2]
        expect( Room.available_rooms(start_date.next_day, end_date.next_day, lux_room_type.name)).to eq [lux_room]
      end
    end
  end
end
