class Api::V1::WinesController < ApplicationController
  # GET /api/v1/wines
  def index
    if params[:min_price] && params[:max_price]
      @wines = Wine.where('price_euros >= ? AND price_euros <= ?', params[:min_price], params[:max_price])
    elsif params[:min_price]
      @wines = Wine.where('price_euros >= ?', params[:min_price])
    elsif params[:max_price]
      @wines = Wine.where('price_euros <= ?', params[:max_price])
    else
      @wines = Wine.all
    end

    render json: @wines
  end

  # GET /api/v1/wines/:id
  def show
    @wine = Wine.find(params[:id])
    render json: @wine
  end

  # POST /api/v1/wines
  def create
    @wine = Wine.create(wine_params)
    render json: @wine
  end

  # PATCH /api/v1/wines/:id
  def update
    @wine = Wine.find(params[:id])
    @wine.update(wine_params)
    render json: @wine
  end

  # DELETE /api/v1/wines/:id
  def destroy
    @wine = Wine.find(params[:id])
    @wine.destroy
    render json: @wine
  end
end
