class Api::V1::SearchesController < ApplicationController

  def index
    render json: Search.all
  end

  def create
    Search.create(min_price: params[:min_price], max_price: params[:max_price], notification_email: params[:notification_email])
    render status: :created
  end
end
