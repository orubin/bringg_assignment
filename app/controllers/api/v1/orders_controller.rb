require 'api_manager'
require 'utils/date_helper'
require 'orders_helper'

class Api::V1::OrdersController < ApplicationController
    before_action :validate_params, only: :create
    before_action :set_params

    def create
      create_user_params = { name: @name, address: @address, phone: @phone, email: @email }
      create_task_params = { order_details: @order_details }

      APIManager.create_user(create_user_params)
      APIManager.create_task(create_task_params)
      
      render json: { status: "ok", data: 'Order and user created' }
    end

    def get_last_week_orders
      render json: {error: 'Missing phone'}, status: 422 and return if @phone.nil? || @phone.empty?
      start_date, end_date = DateHelper.get_previous_week_dates
      response = OrdersHelper.get_orders_per_timeframe(@phone, start_date, end_date)
      
      if response
        render json: { status: "ok", data: response }
      else
        render json: { status: "ok", data: 'No response from API' }
      end
    end

    def show
      result = {}

      render json: { status: "ok" , data: result }
    end

    def update
      result = {}

      render json: { status: "ok" , data: result }
    end

    private

    def validate_params
      errors = []
      errors.push("Missing name") if !params[:name] || params[:name] == ''
      errors.push("Missing address") if !params[:address] || params[:address] == ''
      errors.push("Missing order details") if !params[:order_details] || params[:order_details] == '' || params[:order_details] == {}
      render json: {error: errors.join(', ')}, status: 422 if errors && errors.length > 0
    end

    def set_params
      @order_id = params[:id].to_i
      @name = params[:name].to_s
      @address = params[:address].to_s
      @phone = params[:phone].to_s
      @email = params[:email].to_s
      @order_details = params[:details]
    end
end
