# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Validators::Reservation::ReservationContract, type: :model, dbclean: :after_each do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:contract_params) do
    { :start_date => Date.today,
      :end_date => Date.today,
      :room_type => 'Deluxe Rooms',
      :num_of_user => '3'
    }
  end

  let(:user) { FactoryBot.create(:user) }
  let!(:dex_room_type)  { FactoryBot.create(:room_type, name: "Deluxe Rooms") }
  let!(:dex_room)       { FactoryBot.create(:room, room_type: dex_room_type) }

  context 'success case' do
    before  do
      @result = subject.call(contract_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end


    context 'for user_id being optional' do
      before do
        contract_params.merge!({user_id: nil})
        @result = subject.call(contract_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should not have any errors' do
        expect(@result.errors.empty?).to be_truthy
      end
    end

    context 'for room_id being optional' do
      before do
        contract_params.merge!({room_id: nil})
        @result = subject.call(contract_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should not have any errors' do
        expect(@result.errors.empty?).to be_truthy
      end
    end
  end

  context 'failure case' do

    context 'start date is in the past' do
      before  do
        contract_params.merge!({start_date: Date.today - 1.day})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to eq('Check In date must be Current date or Future Date')
      end
    end

    context 'end date is less than start date' do
      before  do
        contract_params.merge!({start_date: Date.today, end_date: Date.today  - 3.days})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date is after end date' do
        expect(@result.errors.messages.first.text).to eq('Check Out date must be after start date')
      end
    end

    context 'end date is after 6 months' do
      before  do
        contract_params.merge!({start_date: Date.today, end_date: Date.today + 7.months})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it "should return error end date can't be more than 6 months" do
        expect(@result.errors.messages.first.text).to eq("Check Out date can't exceed 6 months, date should be before #{Date.today + 6.months}")
      end
    end

    context 'all rooms reserved' do
      let!(:reservation) { FactoryBot.create(:reservation, start_date: Date.today, end_date: Date.today, room: dex_room, user: user) }
      before  do
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message if title already exists' do
        expect(@result.errors.messages.first.text).to eq("#{dex_room_type.name} Room not available for provided date")
      end
    end
  end
end
