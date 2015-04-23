require './lib/utils/load_libraries.rb'

# handle arguments
filepath = ARGV[0]
duration = ARGV[1]

raise "Invalid number of arguments" if ARGV.size != 2

# add booking information to dummy database
db_instance = DatabaseMock.new(filepath)

# set booking manager with real or dummy database
bookingManager = BookingManager.new(db_instance)

# serch for next free slot
response = bookingManager.get_next_free_slot(duration)

# pretty print result to user
puts response
