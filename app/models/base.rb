class Base

  attr_accessor :id

  def initialize(arg)
    @id = arg
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  class << self
    [:id].each do |method_name|
      define_method "find_or_create_by_#{method_name}" do |arg|
        obj = self.all.find { |ob| ob.send(method_name).to_s == arg.to_s }
        obj.nil? ? self.new(arg) : obj
      end
    end
  end

end
