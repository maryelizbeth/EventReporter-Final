#Dependencies
require 'csv'
# require './event_data_parser'
# require './search'
# require './EventReporterCLI'

#Class Definition
class Queue 
  attr_accessor :queue

  def initialize
    @@queue = []
  end

  def self.queue(value)
     @@queue = value
  end

  def self.queue
    @@queue
  end

  @@queue = []


  def self.call(parameters)
   return true
  end

  def self.valid_parameters_for_queue?(parameters, queue)
    if !%w(count clear print save).include?(parameters[0])
      return true

    elsif parameters [0] == "count"
      @@queue.count 
      puts "There are #{Queue.queue.count} items in the queue"
      return true

    elsif parameters [0] == "clear"
      if @@queue != []
         @@queue = []
      puts "The queue has been cleared."
      return true
      elsif @@queue == []
        puts "The queue was empty. Unable to clear empty queue."
        return true
      end
      
    elsif parameters[0] == "print"  && parameters.count == 1 
      puts "Printing your queue results."
      print "LAST NAME".ljust(16) + 
      "FIRST NAME".ljust(20) + 
      "EMAIL".ljust(40) +
      "ZIPCODE".ljust(20) + 
      "CITY".ljust(24) + 
      "STATE".ljust(20) + 
      "ADDRESS\n"

      @@queue.select do |line|
        print "#{line.last_name}".capitalize.ljust(16) +
        "#{line.first_name}".capitalize.ljust(20) +
        "#{line.email}".capitalize.ljust(40) +
        "#{line.zipcode}".capitalize.ljust(20) +
        "#{line.city}".capitalize.ljust(24) + 
        "#{line.state}".upcase.ljust(20) + 
        "#{line.street}\n"   
    end   

    elsif  parameters.count==2||(parameters[0]=="print" && parameters[1]=="by")
      puts ["LAST NAME", "FIRST NAME", "EMAIL", "ZIPCODE", 
            "CITY", "STATE", "ADDRESS"].join("\t")
      attribute = (parameters[2]).to_sym
      sort = @@queue.sort_by{|line| line.send(attribute)}
        sort.each do |line|
          puts "#{line.last_name}".capitalize.ljust(16) +
          "#{line.first_name}".capitalize.ljust(20) +
          "#{line.email}".capitalize.ljust(40) +
          "#{line.zipcode}".capitalize.ljust(20) +
          "#{line.city}".capitalize.ljust(24)+ 
          "#{line.state}".upcase.ljust(20) + 
          "#{line.street}" 
    end
      

    elsif parameters[0] == "save"
      parameters[1] == "to" && parameters.count == 3 
      output = CSV.open(parameters[2], "w") do |output|
        output << ["last_name", "first_name", "email", "zipcode",
                   "city", "state", "street"]
        @@queue.each do |line|
          output << [" ", line.regdate, line.first_name, line.last_name,
          line.email, line.homephone, line.street, line.city,
          line.state, line.zipcode].join(",") + "\n"
        end
      end
      puts "Saving your queue"
    else 
      return self
    end 
  end 
end 