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
      # post new_order_url, params: { 'name': 'test', 'address': 'addrestest', 'order_details': {'a': 1} }
      # assert_response :success
      # assert JSON.parse(response.body)['error'] == "Missing order details"
    end
    
    
end