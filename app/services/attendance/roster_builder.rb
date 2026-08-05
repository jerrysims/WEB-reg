module Attendance
  class RosterBuilder
    def self.create_for!(school_day)
      new(school_day).create_for!
    end

    def initialize(school_day)
      @school_day = school_day
    end

    def create_for!
      @school_day.build_daily_roster!
    end
  end
end
