class Restaurant 
    
    ## CLASS METHODS ##
    
    @@filepath = nil
    def self.filepath=(path=nil) #setter method, allows call from outside of class
        @@filepath = File.join(APP_ROOT, path) #sets filepath relative to APPROOT
    end
    
    attr_accessor :name, :cuisine, :price
    
    def self.file_exists?   # check if the restaurant file exists
        if @@filepath &&File.exists?(@@filepath)
            return true
        else
            return false
        end
    end
    
    def self.file_usable?   # check if file exists and is usable
        return false unless @@filepath
        return false unless File.exists?(@@filepath)
        return false unless File.readable?(@@filepath)
        return false unless File.writable?(@@filepath)
        return true
    end
    
    def self.create_file    # create the restaurant file if it doesn't exist
        File.open(@@filepath, 'w') unless file_exists?
        return file_usable?
    end

    def self.saved_restaurants 
        # read the restaurant file
        # return instances of restaurant
    end
    
    ## INSTANCE METHODS ##
    
    def save                # save added restaurants and append to list
        return false unless Restaurant.file_usable?
        File.open(@@filepath, 'a') do |file|
            file.puts "#{[@name, @cuisine, @price].join("\t")}"
        end
        return true 
    end

end