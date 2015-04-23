class DatabaseMock
  attr_accessor :bookings

  def initialize(filepath)
    @bookings = []

    File.open(filepath, "r") do |f|
      column_names = f.first.split(' ')
      column_values = []
      f.each_line do |line|
        column_values << line.split(' ')
      end

      bookingId_index = column_names.index('bookingId')
      roomId_index = column_names.index('roomId')
      bookerName_index = column_names.index('bookerName')
      startTime_index = column_names.index('startTime')
      endTime_index = column_names.index('endTime')

      column_values.each { |booking|
        @bookings << Booking.new(
          booking[bookingId_index],
          booking[roomId_index],
          booking[bookerName_index],
          booking[startTime_index],
          booking[endTime_index]
        )
      }
    end
  end
end

