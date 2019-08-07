require 'test_helper'
require 'orders_helper'
require 'api_manager'

class OrdersHelperTest < ActionDispatch::IntegrationTest

  test 'should get empty result for no values' do
    res = OrdersHelper.get_orders_per_timeframe(nil, nil, nil)
    assert res == []
  end
  test 'should get empty result for one value' do
    res = OrdersHelper.get_orders_per_timeframe('+9728887766', nil, nil)
    assert res == []
  end
  test 'should get empty result for one missing value' do
    res = OrdersHelper.get_orders_per_timeframe('+9728887766', Date.today, nil)
    assert res == []
  end
  test 'should get empty result for reversed range date' do
    APIManager.stubs(:get_tasks).returns(populate_tasks_array((Time.now + 1.day).iso8601, 3).to_json, [].to_json)
    res = OrdersHelper.get_orders_per_timeframe('+9728887766', Date.today, Date.today.prev_day)
    assert res == []
  end
  test 'should get empty result for far away tasks' do
    APIManager.stubs(:get_tasks).returns(populate_tasks_array((Time.now - 14.day).iso8601, 3).to_json, [].to_json)
    res = OrdersHelper.get_orders_per_timeframe('+9728887766', Date.today.prev_day, Date.today)
    assert res == []
  end
  test 'should get one order for today task' do
    tasks = populate_tasks_array((Time.now - 2.day).iso8601, 3)
    yesterday = (Time.now - 1.day).iso8601
    tasks.unshift({'scheduled_at': yesterday})
    APIManager.stubs(:get_tasks).returns(tasks.to_json, [].to_json)
    res = OrdersHelper.get_orders_per_timeframe('+9728887766', Date.today.prev_day, Date.today)
    assert res.size == 1
    assert res[0]['scheduled_at'] == yesterday
  end
  test 'should get tasks from two pages in the API' do
    tasks = populate_tasks_array((Time.now).iso8601, 3)
    yesterday = (Time.now - 1.day).iso8601
    old_tasks = populate_tasks_array(yesterday, 3)
    APIManager.stubs(:get_tasks).returns(tasks.to_json, old_tasks.to_json, [].to_json)
    res = OrdersHelper.get_orders_per_timeframe('+9728887766', Date.today.prev_day.prev_day, Date.today.prev_day)
    assert res.size == 3
    assert res[0]['scheduled_at'] == yesterday
    assert res[1]['scheduled_at'] == yesterday
    assert res[2]['scheduled_at'] == yesterday
  end
  

  private

  def populate_tasks_array(date, quantity)
    result = []
    (1..quantity).each do |i|
      result << {'scheduled_at': date}
    end
    result
  end
end