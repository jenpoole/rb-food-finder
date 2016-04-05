APP_ROOT = File.dirname(__FILE__)

# require files within lib folder
$: .unshift( File.join(APP_ROOT, 'lib') )
require 'guide'


guide = Guide.new('restaurants.txt')
guide.launch!