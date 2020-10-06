require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, :type => :controller, :dbclean => :after_each do

  let!(:current_user) { FactoryBot.create(:user) }
  let!(:dex_room_type)  { FactoryBot.create(:room_type, name: "Deluxe Rooms") }
  let!(:dex_room)       { FactoryBot.create(:room, room_number: "A01", room_type: dex_room_type) }
  let!(:dex_room2)       { FactoryBot.create(:room, room_number: "A02", room_type: dex_room_type) }
  let!(:reservation) { FactoryBot.create(:reservation, start_date: Date.today, end_date: Date.today, room: dex_room, user: current_user) }

  before do
    controller.should_receive(:authenticate_user!)
    controller.stub(:current_user).and_return current_user
  end

  describe "gets all reservations" do
    before { get :index }

    it 'returns all reservations' do
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).first["room_type"]).to eq reservation.room_type
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
      expect(response.status).to eq 200
    end
  end

  describe "gets all availabile_rooms" do
    before { get :availabile_rooms }

    it 'returns all available rooms' do
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).first["room_number"]).to eq dex_room2.room_number
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
      expect(response.status).to eq 200
    end
  end
end
