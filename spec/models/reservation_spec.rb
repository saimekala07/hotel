require 'rails_helper'
require 'spec_helper'

RSpec.describe Reservation, :type => :model, :dbclean => :after_each do

  let(:user) { FactoryBot.create(:user) }
  let!(:dex_room_type)  { FactoryBot.create(:room_type, name: "Deluxe Rooms") }
  let!(:lux_room_type)  { FactoryBot.create(:room_type, name: "Luxury Rooms") }
  let!(:dex_room1)       { FactoryBot.create(:room, room_type: dex_room_type) }
  let!(:dex_room2)       { FactoryBot.create(:room, room_type: dex_room_type) }
  let!(:lux_room)       { FactoryBot.create(:room, room_type: lux_room_type) }
  let!(:reservation) { FactoryBot.create(:reservation, start_date: start_date, end_date: end_date, room: dex_room1, user: user) }
  let!(:reservation2) { FactoryBot.create(:reservation, room: lux_room, start_date: start_date, end_date: end_date, user: user) }
  let(:start_date)   { Date.today }
  let(:end_date)     { Date.today }

  describe "#reserved_rooms" do

    context "rooms reserved for a given date period" do
      it "should return reserved rooms ids, if reservations found a date period" do
        expect(Reservation.reserved_rooms(start_date, end_date)).to eq [dex_room1.id, lux_room.id]
      end
    end

    context "rooms reserved for a next day" do
      it "should return empty array, if no reservation for a date period" do
        expect(Reservation.reserved_rooms(start_date.next_day, end_date.next_day)).to eq []
      end
    end
  end
end
