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
          booking[bookingId_index].to_i,
          booking[roomId_index].to_i,
          booking[bookerName_index],
          Time.parse(booking[startTime_index]).to_i,
          Time.parse(booking[endTime_index]).to_i
        )
      }
    end
  end
end

