require 'rails_helper'

RSpec.describe Report, type: :model do

  let(:file) { File.open(File.dirname(__FILE__) + '/../input.txt', 'r') }

  before { ObjectSpace.garbage_collect }

  describe '.initialize' do

    subject { Report.new(file) }

    it 'should create a new Report object' do
      expect(subject).to be_an_instance_of(Report)
      expect(subject).to have_attributes(file: file, report_hash: {})
    end
  end

  describe '.generate' do

    subject { Report.new(file).generate }

    it 'should return parsed and formatted report in a hash' do
      expect(subject).to include('0' => [1, 20])
    end
  end

  describe '.build' do

    before { Report.new(file).build }

    it 'should create Period, Room, Visitor objects' do
      expect(Visitor.all).to_not be_empty
      expect(Period.all).to_not be_empty
      expect(Room.all).to_not be_empty
    end
  end

  describe '.get_report' do

    let(:report) { Report.new(file) }

    before { report.build }

    subject { report.get_report }

    it 'should return parsed and formatted report in a hash' do
      expect(subject).to include('0' => [1, 20])
    end
  end
end
