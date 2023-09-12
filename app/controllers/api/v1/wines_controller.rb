class Api::V1::WinesController < ApplicationController

  # GET /api/v1/wines
  def index
    if params[:min_price] && params[:max_price]
      wines = Wine.where('price_euros >= ? AND price_euros <= ?', params[:min_price], params[:max_price])
    elsif params[:min_price]
      wines = Wine.where('price_euros >= ?', params[:min_price])
    elsif params[:max_price]
      wines = Wine.where('price_euros <= ?', params[:max_price])
    else
      wines = Wine.all
    end
    sorted_wines = wines.order('note DESC')

    render json: sorted_wines, include: :reviews
  end

  # GET /api/v1/wines/:id
  def show
    wine = Wine.find(params[:id])
    render json: wine
  end

  # POST /api/v1/wines
  def create
    ServicesRegistry.new.wine_service.create_wine(params[:name], params[:price_euros], params[:store_url])
    render status: :created
  end

  # POST /api/v1/wines/:id/reviews
  def add_review
    wine = Wine.find(params[:id])
    wine.reviews << Review.create(note: params[:note], comment: params[:comment])
    render status: :created
  end
end
