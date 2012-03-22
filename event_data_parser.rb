#Dependencies 
require './attendee'
require 'csv'
#require './search'

#Class Definition
class EventDataParser

  attr_accessor :attendees 

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}
  @attendees = []

    def self.initialize (parameters)
      @attendees =[]
    end

    def self.attendees(value)
      @attendees = value
    end 
    def self.attendees 
      @attendees
    end 

    def self.valid_parameters_for_load?(parameters)
      parameters.count == 1 && parameters[0] =~ /\.csv$/
    end

    def self.load(filename, options = CSV_OPTIONS)
        load_attendees(CSV.open(filename, CSV_OPTIONS))
      # else
      #   load_attendees(CSV.open(filename, CSV_OPTIONS))
      # end
    end 

    def self.load_attendees(file)
      @attendees = file.collect {|line| Attendee.new(line)}
    end 

    # def self.load_default(file)
    #   @file = CSV.open("event_attendees.csv", CSV_OPTIONS)
    #   @attendees = file.collect {|line| Attendee.new(line)}
    # end 
 end

 
