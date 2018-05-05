require 'rails_helper'

RSpec.describe Base, type: :model do

  before { ObjectSpace.garbage_collect }

  describe '.initialize' do
    subject { Base.new(0) }

    it 'should return base object' do
      expect(subject).to be_an_instance_of(Base)
      expect(subject).to have_attributes(id: 0)
    end
  end

  describe '.all' do
    subject { Base.all }

    context 'without any base object' do
      it 'should return empty array' do
        expect(subject).to be_an_instance_of(Array)
        expect(subject).to be_empty
      end
    end

    context 'with base object' do

      before { Base.new(0) }

      it 'should return the array of base objects' do
        expect(subject).to be_an_instance_of(Array)
        expect(subject).to_not be_empty
        expect(subject[0]).to be_an_instance_of(Base)
        expect(subject[0].id).to eq(0)
      end
    end
  end

  describe '.find_or_create_by_id' do

    subject { Base.find_or_create_by_id(0) }

    context 'when no base object found' do
      it 'should create a new base object' do
        expect(subject).to be_an_instance_of(Base)
        expect(subject.id).to eq(0)
        expect(Base.all.size).to eq(1)
        expect(Base.all.include?(subject)).to be_truthy
      end
    end

    context 'when base object found' do
      it 'should not create a new base object' do 
        expect(subject).to be_an_instance_of(Base)
        expect(subject.id).to eq(0)
        expect(Base.all.size).to eq(1)
        expect(Base.all.include?(subject)).to be_truthy
      end
    end

  end

end
