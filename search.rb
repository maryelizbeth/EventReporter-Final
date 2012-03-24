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
    parameters.count >= 2

  end 

  def self.find(parameters, attendees)
    
    attribute = parameters[0]
    criteria = parameters[1..-1].join(" ")
    Queue.new

    EventDataParser.attendees.each do |attendee|
      if attendee.send(attribute.to_sym).downcase == criteria.downcase
        Queue.queue << attendee
      end
    end

    puts "This search has added #{Queue.queue.count} results to the queue." 
    return Queue.queue
  end
end 
