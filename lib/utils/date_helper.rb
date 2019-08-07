module DateHelper
  def self.get_previous_week_dates
    date = Date.today
    end_date = date-date.wday
    start_date = date-date.wday-6
    [start_date, end_date]
  end
end