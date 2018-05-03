class AnalysisController < ApplicationController

  def index
    File.open('./log/input1.log', 'r') do |f|
      f.each_line do |line|
        Period.job(line)
      end
    end

    Room.all.sort_by { |r| r.id.to_i }.each do |room|
      p room.inspect
      period = Period.all.find_all{ |p| p.room == room.id.to_i }
      total_time = 0
      period.each do |p|
        time = p.time_out.to_i - p.time_in.to_i
        total_time = total_time + time
      end

      p avg = total_time / period.count
    end
  end

end
