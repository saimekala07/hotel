require 'rails_helper'

RSpec.describe Operations::Reservation::Persist, type: :model, dbclean: :after_each do

  let(:user) { FactoryBot.create(:user) }
  let!(:dex_room_type)  { FactoryBot.create(:room_type, name: "Deluxe Rooms") }
  let!(:dex_room)       { FactoryBot.create(:room, room_type: dex_room_type) }

  let(:reservation_create_params) do
    { :start_date => Date.today,
      :end_date => Date.today,
      :room_type => 'Deluxe Rooms',
      :num_of_user => '3'
    }
  end

  context "create Reservation" do

    it 'should be a container-ready operation' do
      expect(subject.respond_to?(:call)).to be_truthy
    end

    context 'for success case' do
      context 'should create reservation' do
        before :each do
          @result = subject.call(params: reservation_create_params, user: user)
        end

        it 'should return success' do
          expect(@result).to be_a(Dry::Monads::Result::Success)
        end

        it 'should return a reservation object' do
          expect(@result.success).to be_a(::Reservation)
        end

        it 'should create Reservation object' do
          expect(::Reservation.all.count).to eq(1)
        end
      end
    end

    context 'for failure case' do
      let(:reservation_create_params) do
        { :start_date => Date.today,
          :end_date => Date.today - 1.day,
          :room_type => 'Deluxe Rooms',
          :num_of_user => '3'
        }
      end

      before :each do
        @result = subject.call(params: reservation_create_params, user: user)
      end

      it 'should return failure' do
        expect(@result).to be_a(Dry::Monads::Result::Failure)
      end

      it 'should return error message' do
        expect(@result.failure[1]).to eq(['Check Out date must be after start date'])
      end

      it 'should not create any Reservation objects' do
        expect(::Reservation.all.count).to be_zero
      end
    end
  end

  context "all rooms reserved" do
    let!(:reservation) { FactoryBot.create(:reservation, start_date: Date.today, end_date: Date.today, room: dex_room, user: user) }
    before  do
      @result = subject.call(params: reservation_create_params, user: user)
    end

    it 'should return failure' do
      expect(@result.failure?).to be_truthy
    end

    it 'should have any errors' do
      expect(@result.failure[0].errors.empty?).to be_falsy
    end

    it 'should return error message if title already exists' do
      expect(@result.failure[0].errors.messages.first.text).to eq("#{dex_room_type.name} Room not available for provided date")
    end

  end
end
