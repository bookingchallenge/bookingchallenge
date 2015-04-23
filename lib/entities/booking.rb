class Booking
  attr_accessor :id, :room_id, :person_id, :start_time, :end_time

  def initialize(id, room_id, person_id, start_time, end_time)
    self.id = id
    self.room_id = room_id
    self.person_id = person_id
    self.start_time = start_time
    self.end_time = end_time
  end
end
