require "restaurant" # loads Restaurant class before Guide class 

class Guide
    
    def initialize(path=nil)
        Restaurant.filepath = path      # locate the restaurant text file at path
        if Restaurant.file_usable?      # if file exists and is usable
            puts "Found restaurant file."
        elsif Restaurant.create_file    # or create a new file
            puts "Created restaurant file."
         else                           # or exit if create fails
            puts "Exiting."
            exit!
        end
    end
    

    def launch!         # launch method
        introduction    # welcomes user to app
        #action loop 
        result = nil
        until result == :quit # repeat until user quits app
            # ask for user input, what do you want to do? choices: list, find, add, quit
            user_response = gets.chomp
            # perform the chosen action
            result = do_action(user_response)
        end
        conclusion      # goodbye message to user
    end
    
    def do_action(action) # action method
        case action
        when 'list'
            puts "Listing..."
        when 'find'
            puts "Finding..."
        when 'add'
            puts "Adding..."
        when 'quit'
            return :quit
        else 
            puts "I don't understand."
        end
    end
    
    def introduction    #introduction method
        puts "<<< Welcome to the Food Finder >>>"
        puts "This is an interactive guide to help you find the food you crave."
    end
    
    def conclusion    #conclusion method
        puts "<<< Goodbye and Bon Appetit! >>>"
    end
    
end