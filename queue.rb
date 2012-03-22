#Dependencies
require 'csv'
# require './event_data_parser'
# require './search'
# require './EventReporterCLI'

#Class Definition
class Queue < Array
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
    "Running queue sub-function #{parameters[0]}"
  end

  def self.valid_parameters_for_queue?(parameters, queue)
    if !%w(count clear print save).include?(parameters[0])
      return true

    elsif parameters [0] == "count"
      @@queue.count 
      puts "There are #{Queue.queue.count} items in the queue"

    elsif parameters [0] == "clear"
      puts "The queue has been cleared." 
      if @@queue != []
         @@queue = []
      else
        puts "There are 0 items in the queue."
      end
      
    elsif parameters[0] == "print"  
      puts "Printing your queue results."
      print "LAST NAME".ljust(16) + 
      "FIRST NAME".ljust(20) + 
      "EMAIL".ljust(40) +
      "ZIPCODE".ljust(20) + 
      "CITY".ljust(24) + 
      "STATE".ljust(20) + 
      "ADDRESS\n"
      puts @@queue

      @@queue.select do |line|
        print "#{line.last_name}".capitalize.ljust(16) +
        "#{line.first_name}".capitalize.ljust(20) +
        "#{line.email}".capitalize.ljust(40) +
        "#{line.zipcode}".capitalize.ljust(20) +
        "#{line.city}".capitalize.ljust(24) + 
        "#{line.state}".upcase.ljust(20) + 
        "#{line.street}\n"   
    end   

    elsif  parameters.count==1||(parameters[1]=="by" && parameters.count ==3)
      puts ["LAST NAME", "FIRST NAME", "EMAIL", "ZIPCODE", 
            "CITY", "STATE", "ADDRESS"].join("\t")

      keys = parameters[2]
      @@queue = @@queue.sort_by{|attendee| attendee.send(keys.to_sym)} 
      @@queue.each do |line|
      @@queue << line.to_s
    
      puts "#{line.last_name}".capitalize.ljust(16) +
      "#{line.first_name}".capitalize.ljust(20) +
      "#{line.email}".capitalize.ljust(40) +
      "#{line.zipcode}".capitalize.ljust(20) +
      "#{line.city}".capitalize.ljust(24)+ 
      "#{line.state}".upcase.ljust(20) + 
      "#{line.street}\n"   
      end 

    elsif parameters[0] == "save"
      parameters[1] == "to" && parameters.count == 3 
      output = CSV.open(parameters[2], "w") do |output|
        output << ["last_name", "first_name", "email", "zipcode",
                   "city", "state", "street"]
        @@queue.each do |line|
          output << [line.last_name, line.first_name, line.email,
                     line.zipcode, line.city, line.state, line.street]
        end
      end
      puts "Saving your queue"
    else 
      return self
    end 
  end 
end 