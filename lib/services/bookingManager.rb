require 'time'

class BookingManager
  attr_accessor :db

  DEFAULT_TIME_CHECKPOINT = '2015-04-01T00:00'
  DEFAULT_BOOKING = -> (start_time, end_time, duration) { Booking.new(1, 'Administrator', start_time, end_time, duration) }

  def initialize(db)
    self.db = db
  end

  def get_next_free_slot(duration)
    # NOTE: One huge assumption here, bookings are
    # sorted in ascending order by created_at
    time_checkpoints = {}
    start_time = end_time = ""

    bookings = db.bookings
    bookings.each { |booking|
      # get relevant booking info
      start_time = booking.start_time
      end_time = booking.end_time
      room_id = booking.room_id

      # get current time checkpoint for the given room
      time_checkpoint = time_checkpoints.fetch(room_id) { DEFAULT_TIME_CHECKPOINT }

      # check if there is any slot free between the last and this booking
      delta_time = (start_time.to_i - time_checkpoint.to_i) * 60
      return booking if delta_time > duration.to_i

      # there is no free slot, so push time checkpoint to the end of this booking
      time_checkpoints[room_id] = end_time
    }
    # when there is no free slot we'll take the firs available for the 1st room
    new_start_time = end_time
    new_end_time = Time.parse(end_time) + duration
    return DEFAULT_BOOKING.call(new_start_time, new_end_time, duration)
  end
end
