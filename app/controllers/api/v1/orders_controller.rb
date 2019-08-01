class Api::V1::OrdersController < ApplicationController
    before_action :validate_params, only: :create
    before_action :set_params

    def create
      
      render json: { status: "ok", data: "Order created" }
    end

    def show
      # @locations = Rails.cache.fetch('locations', expires_in: 60.seconds) do
      #     Location.all
      # end

      # @locations = @locations.sort_by{|loc| loc[:country]} if @order_by_country

      # @locations = @locations.select{|loc| loc[:country] == @filter_by_country} if @filter_by_country

      result = {}

      # if @locations
      #     @locations.each do |loc|
      #         result << loc.as_json
      #     end
      # end

      render json: { status: "ok" , data: result }
    end

    def update
      result = ''

      render json: { status: "ok" , data: result }
    end

    private

    def validate_params
      errors = []
      errors.push("Missing name") if !params[:name] || params[:name] == ''
      errors.push("Missing address") if !params[:address] || params[:address] == ''
      errors.push("Missing order details") if !params[:order_details] || params[:order_details] == '' || params[:order_details] == {}
      # render json: { status: 422 , data: errors.join(', ') }
      render json: {error: errors.join(', ')}, status: 422 if errors && errors.length > 0
    end

    def set_params
      @order_id = params[:id].to_i
      @name = params[:name].to_s
      @address = params[:address].to_s
      @order_details = params[:details]
    end
end