module Delegate
  def delegate_work(worker, new_work_content)
    worker.work_content = new_work_content
  end
end

class Employee
  attr_reader :name, :serial_num, :job_type, :vacation, :desk
  attr_accessor :work_content

  def initialize(name, serial_num, job_type)
    @name = name
    @serial_num = serial_num
    @job_type = job_type
    @work_content = nil
  end
end

class Executive < Employee
  def initialize(name, serial_num, job_type)
    super
    @vacation = 20
    @desk = "corner office"
  end

  def name 
    "Exe. #{@name}"
  end
end

class Manager < Employee
  include Delegate

  def initialize(name, serial_num, job_type)
    super
    @vacation = 14
    @desk = "private office"
  end

  def name
    "Mgr. #{@name}"
  end
end

class Regular < Employee
  def initialize(name, serial_num, job_type)
    super
    @vacation = 10
    @desk = "cubicle farm"
  end
end

class PartTime < Employee
  def initialize(name, serial_num, job_type)
    super
    @vacation = 0
    @desk = "no reserved desk"
  end
end

manager = Manager.new("Lin", 1235, "full-time")
regular = Regular.new("Andty", 1234, "full-time")
puts manager
puts manager.vacation
puts manager.desk
puts manager.name
puts regular.work_content
manager.delegate_work(regular, "hey")
puts regular
puts regular.work_content