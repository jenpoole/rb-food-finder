require "restaurant" # loads Restaurant class before Guide class 

class Guide
    
    class Config
        @@actions = ['list', 'find', 'add', 'quit'] # actions available for user
        def self.actions; @@actions; end
    end
    
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
            # get action from user input
            action = get_action
            # perform the chosen action
            result = do_action(action)
        end
        conclusion      # goodbye message to user
    end
    
    def get_action      # method: get action from user input
        action = nil
        # Keep asking for user input until a valid action is entered
        until Guide::Config.actions.include?(action)
            puts "Actions: " + Guide::Config.actions.join(", ") if action
            user_response = gets.chomp
            action = user_response.downcase.strip # modify user input by downcasing and removing spaces
        end
        return action
    end
    
    def do_action(action) # method: do action
        case action
        when 'list'
            list
        when 'find'
            puts "Finding..."
        when 'add'
            add         # calls add method
        when 'quit'
            return :quit
        else 
            puts "I don't understand."
        end
    end
    
    def list            # method to list restaurants
        puts "\nListing restaurants \n\n".upcase
        restaurants = Restaurant.saved_restaurants
        
        restaurants.each do |place|
            puts place.name + "|" + place.cuisine + "|" + place.price
        end
    end
    
    
    def add             # method to add restaurants
        puts "Add a restaurant".upcase
        
        restaurant = Restaurant.build_using_questions
        
        if restaurant.save
            puts "Restaurant Added"
        else
            puts "Error: Restaurant not added"
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