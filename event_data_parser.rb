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
      if parameters.count == 1 && parameters[0] =~ /\.csv$/
        return true
      elsif parameters.nil?
        self.load_default
      else 
        return false
      end
    end

    def self.load(filename)
      @file = CSV.open(filename, CSV_OPTIONS)
      @attendees = @file.collect {|line| Attendee.new(line)}
    end 

    def self.load_attendees(file)
      @attendees = file.collect {|line| Attendee.new(line)}
    end 

    def self.load_default(filename)
      @file = CSV.open("event_attendees.csv", CSV_OPTIONS)
      @attendees = @file.collect {|line| Attendee.new(line)}
    end 
 end

 
