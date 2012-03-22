#Dependencies 
# require 'csv'
# require './event_data_parser'
# require './queue'
# require './EventReporterCLI'

#Class Definitions
class Search 

  attr_accessor :queue, :attendees

  # def self.for(parameters)
  #   puts "Here's a search for #{parameters.join(" ")}"
  #    puts @queue.size
  #   #in 'event_attendees.csv'
  # end

  def self.valid_parameters?(parameters)
    #Check that attribute is valid 
    parameters.join(" ")
    if parameters.count == 2
      puts "Searching for #{parameters}"
      return true
    end
  end 

  def self.find(parameters, attendees)
    
    attribute = parameters[0]
    criteria = parameters[1..-1].join " "
    Queue.new

    EventDataParser.attendees.each do |attendee|
      if attendee.send(attribute.to_sym).downcase == criteria.downcase
        Queue.queue << attendee
      end
    end

    puts "There are #{Queue.queue.count} results in the queue." 
    return Queue.queue
  end
end 
