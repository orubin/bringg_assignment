require 'api_manager'

module OrdersHelper
  def self.get_orders_per_timeframe(phone, start_date, end_date)
    return [] unless phone && start_date && end_date
    result = []
    has_tasks = true
    range = start_date..end_date
    page = 1

    while has_tasks
      tasks = APIManager.get_tasks({phone: phone, start_date: start_date, end_date: end_date, page: page})
      tasks = JSON.parse(tasks)
      if tasks && tasks.size > 0
        tasks.each do |task|
          parsed_date = Date.parse(task['scheduled_at'])
          # binding.pry
          if range === parsed_date
            result << task
          end
          if parsed_date < start_date
            has_tasks = false
          end
        end
      else
        has_tasks = false
      end
      page+=1
    end

    result
  end
end