class Period < Base

  attr_accessor :visitor, :room, :time_in, :status, :time_out

  def initialize(v, r, st, t_in)
    @visitor = v.to_i
    @room = r.to_i
    @time_in = t_in.to_i
    @status = st
  end

  def self.exit_period(v, r, st, t_out)
    period = Period.all.find { |p| p.visitor == v.to_i && p.room == r.to_i }
    period.time_out = t_out.to_i
    period.status = st
  end

  def self.job(inp)
    inp = inp.split(' ')
    visitor = Visitor.find_or_create_by_id(inp[0])
    room = Room.find_or_create_by_id(inp[1])

    case inp[2]
    when 'I'
      Period.new(visitor.id, room.id, inp[2], inp[3])
    when 'O'
      Period.exit_period(visitor.id, room.id, inp[2], inp[3])
    else
      puts 'wrong input'
    end
  end
  
end
