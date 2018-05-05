require 'rails_helper'

RSpec.describe Period, type: :model do

  before { ObjectSpace.garbage_collect }

  describe '.initialize' do
    subject { Period.new(1, 0, 'I', 540) }

    it 'should return period object' do
      expect(subject).to be_an_instance_of(Period)
      expect(subject).to have_attributes(visitor: 1, room: 0, time_in: 540, status: 'I')
    end
  end

  describe '.exit_period' do

    before do
      Period.new(1, 0, 'I', 540)
      Period.exit_period(1, 0, 'O', 560)
    end

    subject { Period.all.find { |p| p.visitor == 1 && p.room == 0 } }

    it "should set period object's status and time_out attributes" do
      expect(subject.time_out).to eq(560)
      expect(subject.status).to eq('O')
    end

  end

  describe '.job' do

    context 'when visitor entering' do

      before { Period.job('0 0 I 540') }

      it 'creates a new visitor, room and period objects' do
        expect(Visitor.all).to_not be_empty
        expect(Visitor.all.count).to eq(1)
        expect(Visitor.all.first.id).to eq('0')
        expect(Room.all).to_not be_empty
        expect(Room.all.count).to eq(1)
        expect(Room.all.first.id).to eq('0')
        expect(Period.all).to_not be_empty
        expect(Period.all.count).to eq(1)
        expect(Period.all.first.visitor).to eq(0)
        expect(Period.all.first.room).to eq(0)
        expect(Period.all.first.time_in).to eq(540)
        expect(Period.all.first.status).to eq('I')
      end
    end

    context 'when visitor exit' do

      before { Period.job('0 0 O 560') }

      it 'updates existing period object' do
        period = Period.all.find { |p| p.visitor == 0 && p.room == 0 }
        expect(Period.all).to_not be_empty
        expect(Period.all.count).to eq(1)
        expect(period.time_out).to eq(560)
        expect(period.status).to eq('O')
      end
    end
  end
end
