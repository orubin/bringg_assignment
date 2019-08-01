require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest

    get_orders_url = '/api/v1/orders/1'
    new_order_url = '/api/v1/orders/new'


    test 'should get orders success' do
        get get_orders_url
        assert_response :success
    end
    test 'should get error code for missing params' do
        post new_order_url
        assert_response 422
        assert JSON.parse(response.body)['error'] == "Missing name, Missing address, Missing order details"
    end
    test 'should get error code for partly missing params' do
      post new_order_url, params: { 'name': 'test' }
      assert_response 422
      assert JSON.parse(response.body)['error'] == "Missing address, Missing order details"
    end
    # test 'should get error code for almost all missing params' do
    #   post new_order_url, params: { 'name': 'test', 'address': 'addrestest' }
    #   assert_response 422
    #   assert JSON.parse(response.body)['error'] == "Missing order details"
    # end
    test 'should get success code' do
      post new_order_url, params: { 'name': 'test', 'address': 'addrestest', 'order_details': {'a': 1} }
      assert_response :success
      # assert JSON.parse(response.body)['error'] == "Missing order details"
    end
    # test "should get locations data right" do
    #     save_location('Test', 'Test')
    #     get get_locations_url
    #     assert JSON.parse(response.body)['data'].size == 1
    #     assert JSON.parse(response.body)['data'].first['name'] == 'Test'
    # end
    # test "should get two locations data right" do
    #     save_location('Test', 'Test')
    #     save_location('Test2', 'Test2')
    #     get get_locations_url
    #     assert JSON.parse(response.body)['data'].size == 2
    #     assert JSON.parse(response.body)['data'].first['name'] == 'Test'
    #     assert JSON.parse(response.body)['data'].last['name'] == 'Test2'
    # end
    # test 'get top locations is empty when no orders' do
    #     insert_locations
    #     get get_top_locations_url
    #     assert_response :success
    #     assert JSON.parse(response.body)['data'] == []
    # end
    # test 'get top locations for one location' do
    #     insert_locations
    #     first_location_id = Location.first.id
    #     Order.new(location_id: first_location_id, room_type: 1, 
    #                 guests_amount: 2, booking_start: '2019-01-01', 
    #                 booking_end: '2019-01-09', user_id: 5).save!
    #     get get_top_locations_url
    #     assert_response :success
    #     assert JSON.parse(response.body)['data'].size == 1
    # end
    # test 'get top locations for two locations' do
    #     insert_locations
    #     Order.new(location_id: Location.first.id, room_type: 1, 
    #                 guests_amount: 2, booking_start: '2019-01-01', 
    #                 booking_end: '2019-01-09', user_id: 5).save!
    #     Order.new(location_id: Location.last.id, room_type: 1, 
    #                 guests_amount: 2, booking_start: '2019-01-01', 
    #                 booking_end: '2019-01-09', user_id: 5).save!
    #     get get_top_locations_url
    #     assert_response :success
    #     assert JSON.parse(response.body)['data'].size == 2
    # end
    # test 'get top locations for two locations - last one has the most' do
    #     insert_locations
    #     last_location_id = Location.last.id
    #     Order.new(location_id: Location.first.id, room_type: 1, 
    #                 guests_amount: 2, booking_start: '2019-01-01', 
    #                 booking_end: '2019-01-09', user_id: 5).save!
    #     Order.new(location_id: last_location_id, room_type: 1, 
    #                 guests_amount: 2, booking_start: '2019-01-01', 
    #                 booking_end: '2019-01-09', user_id: 5).save!
    #     Order.new(location_id: last_location_id, room_type: 1, 
    #                 guests_amount: 2, booking_start: '2019-01-01', 
    #                 booking_end: '2019-01-02', user_id: 7).save!
    #     get get_top_locations_url
    #     assert_response :success
    #     assert JSON.parse(response.body)['data'].size == 2
    #     assert JSON.parse(response.body)['data'].last == last_location_id
    # end
    # test 'get locations - order by country name' do
    #     insert_locations
    #     get get_locations_url, params: { 'order_by_country': true }
    #     assert_response :success
    #     assert JSON.parse(response.body)['data'].size == Location.all.size
    #     JSON.parse(response.body)['data'].first['country'] == Location.all.map(&:country).sort.first
    # end
    
end