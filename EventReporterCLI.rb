#Dependencies 

require 'csv'
require './event_data_parser'
require './queue'
require './help'
require './search'
require './attendee'

#Class Definition 
class EventReporterCLI

  attr_accessor :queue, :attendees

  EXIT_COMMANDS = ["quit", "q", "e", "x", "exit"] 

  ALL_COMMANDS = {"load" => "loads a new file", 
                  "help" => "shows a list of available commands",
                  "queue count" => "total items in the queue", 
                  "queue clear" => "empties the queue",
                  "queue print" => "prints to the queue", 
                  "queue print by" => "prints the specified attribute",
                  "queue save to" => "exports queue to a CSV", 
                  "find" => "load the queue with matching records"}

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

 # @attribute = parameters[0]
 # @criteria = parameters[-1]
 # @command = command
  
 # @attendees = command.attendees


  def initialize 
    @queue = Queue.queue.new
  end 


  def self.valid_command?(command)
    ALL_COMMANDS.keys.include?(command)
  end

  def self.parse_user_input(input)
    [ input.first.downcase, input[1..-1] ]
  end 

  def self.switch_by_command(command,parameters)
    if command == "load" 
      puts "Loading your data."
      if EventDataParser.valid_parameters_for_load?(parameters)
        attendees = EventDataParser.load(parameters.first)

      # elsif !EventDataParser.valid_parameters_for_load?(parameters)
      # attendees = EventDataParser.load_default(parameters)
      # puts "No filename given. event_attendees.csv has been loaded"

      else
        puts "Sorry, the specified filename was not found." 
      end 

    elsif command == "queue"
      if Queue.valid_parameters_for_queue?(parameters, command)
        Queue.call(parameters)
      else
        puts "Sorry, you specified an invalid command for 'queue'."
      end 

    elsif command == "help"
      if Help.valid_parameters_for_help?(parameters)
        Help.for(parameters)
      else 
        puts "Sorry, you specified an invalid command for 'help'."
      end 

    elsif command == "find"
      if Search.valid_parameters?(parameters)
         Search.find(parameters, attendees)
      else
        puts "Sorry, you specified an invalid command for 'find'." 
      end 
    end
  end 

  def self.prompt_user
    printf "Please enter a command > "
    gets.strip.split
  end

  def self.run 

    puts "Welcome to the EventReporter"
    command = "" 

    until EXIT_COMMANDS.include?(command)
    #command == "quit" || command == "exit"
      inputs = prompt_user 

      if inputs.any? 
        command, parameters = parse_user_input(inputs)
        switch_by_command(command, parameters)

      elsif inputs != ALL_COMMANDS.include?(command)
        puts "Sorry, you specified an invalid command."
        puts "Please enter 'help' for a list of available commands."
      end 
    end 
    puts "Thank You, Goodbye!"
  end
end 

#Scripts 
EventReporterCLI.run 