require 'time'

class BookingManager
  attr_accessor :db

  DEFAULT_TIME_CHECKPOINT = Time.parse('2015-04-01T00:00').to_i

  def initialize(db)
    self.db = db
  end

  def get_next_free_slot(duration)
    # NOTE: One huge assumption here, bookings are
    # sorted in ascending order by created_at
    time_checkpoints = {}
    last_booking = nil

    bookings = db.bookings
    bookings.each { |booking|
      last_booking = booking

      # get relevant booking info
      start_time = booking.start_time
      end_time = booking.end_time
      room_id = booking.room_id

      # get current time checkpoint for the given room
      time_checkpoint = time_checkpoints.fetch(room_id) { DEFAULT_TIME_CHECKPOINT }

      # check if there is any slot free between the last and this booking
      delta_time = (start_time - time_checkpoint) / 60
      if delta_time > duration
        return booking.tap { |booking|
          booking.start_time = time_checkpoint
          booking.end_time = time_checkpoint + duration * 60
        }
      end

      # there is no free slot, so push time checkpoint to the end of this booking
      time_checkpoints[room_id] = end_time
    }
    # when there is no free slot we'll take the first available for the 1st room
    return last_booking.tap { |booking|
      booking.start_time = booking.end_time
      booking.end_time += duration * 60
    }
  end
end
