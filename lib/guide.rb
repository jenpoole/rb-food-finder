require 'restaurant' # loads Restaurant class before Guide class 
require 'support/string_extend'

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
            action, args = get_action
            # perform the chosen action
            result = do_action(action, args)
        end
        conclusion      # goodbye message to user
    end
    
    def get_action      # method: get action from user input
        action = nil
        # Keep asking for user input until a valid action is entered
        until Guide::Config.actions.include?(action)
            puts "Actions: " + Guide::Config.actions.join(", ") if action
            user_response = gets.chomp
            args = user_response.downcase.strip.split(' ') # modify user input by downcasing and removing spaces
            action = args.shift
        end
        return action, args
    end
    
    def do_action(action, args=[]) # method: do action
        case action
        when 'list'
            list
        when 'find'
            keyword = args.shift
            find(keyword)
        when 'add'
            add         # calls add method
        when 'quit'
            return :quit
        else 
            puts "I don't understand."
        end
    end
    
    def list            # method to list restaurants
        output_action_header("Listing restaurants")
        restaurants = Restaurant.saved_restaurants
        output_restaurant_table(restaurants)
    end
    
    def find(keyword="")
        output_action_header("Find a restaurant")
        
        if keyword
            #search
            restaurants = Restaurant.saved_restaurants
            found = restaurants.select do |rest|
                rest.name.downcase.include?(keyword.downcase) ||
                rest.cuisine.downcase.include?(keyword.downcase) #||
                # rest.price_to_i <= keyword.to_i
            end
            output_restaurant_table(found)
        else
            puts "Find using a key phrase to search the restaurant list."
            puts "Examples: 'find tamale', 'find Mexican'\n\n"
        end
        
    end
    
    
    def add             # method to add restaurants
        output_action_header("Add a restaurant")
        
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
    
    private
    
    def output_action_header(text)
        puts "\n#{text.upcase.center(60)} \n\n"
    end

  def output_restaurant_table(restaurants=[])
      print " " + "Name".ljust(30)
      print " " + "Cuisine".ljust(20)
      print " " + "Price".rjust(6) + "\n"
      puts "-" * 60
      
      restaurants.each do |rest|
          line = " " << rest.name.titleize.ljust(30)
          line << " " + rest.cuisine.titleize.ljust(20)
          line << " " + rest.formatted_price.rjust(6)
          puts line
      end
      puts "No listings found" if restaurants.empty?
      puts "-" * 60
  end
    
end