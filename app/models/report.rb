class Report

  attr_accessor :file, :report_hash

  def initialize(file)
    @file = file
    @report_hash = {}
  end

  def generate
    ObjectSpace.garbage_collect

    build

    get_report
  end

  def build
    @file.each_line { |line| Period.job(line) }
  end

  def get_report
    Room.all.sort_by { |r| r.id.to_i }.each do |room|
      period = Period.all.find_all{ |p| p.room == room.id.to_i }
      total_time = 0

      period.each do |p|
        time = p.time_out.to_i - p.time_in.to_i
        total_time = total_time + time
      end

      avg = total_time / period.count if period.count > 0
      @report_hash[room.id.to_s] = [period.count, avg] if avg.present?
    end

    @report_hash
  end
end
