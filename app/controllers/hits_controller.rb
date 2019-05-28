class HitsController < ApplicationController
  before_action :set_hit, only: %i[show update destroy]
  
  # GET /hits
  def index
    result = MturkService.list_hits(50)

    respond_with ListHitsResponceSerializer.render(result)
  end

  # GET /hits/1
  def show
    render json: @hit
  end

  # POST /hits
  def create
    @hit = Hit.new(hit_params)

    if @hit.save
      render json: @hit, status: :created, location: @hit
    else
      render json: @hit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hits/1
  def update
    if @hit.update(hit_params)
      render json: @hit
    else
      render json: @hit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hits/1
  def destroy
    @hit.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hit
    @hit = Hit.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def hit_params
    params.fetch(:hit, {})
  end
end
