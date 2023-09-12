class Api::V1::WinesController < ApplicationController

  # GET /api/v1/wines
  def index
    wines = ServicesRegistry.new.wine_service.get_wines(params[:min_price], params[:max_price])
    render json: wines
  end

  # GET /api/v1/wines/:id
  def show
    wine = Wine.find(params[:id])
    render json: wine, include: :reviews
  end

  # POST /api/v1/wines
  def create
    ServicesRegistry.new.wine_service.create_wine(params[:name], params[:price_euros], params[:store_url])
    render status: :created
  end

  # POST /api/v1/wines/:id/reviews
  def add_review
    ServicesRegistry.new.wine_service.add_review_to_wine(params[:id], params[:note], params[:comment])
    render status: :created
  end
end
