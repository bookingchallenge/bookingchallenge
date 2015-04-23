class BookingManager
  attr_accessor :db

  def initialize(db)
    self.db = db
  end

  def get_next_free_slot(duration)
  end
end
