class HitsController < ApplicationController
  # before_action :set_hit, only: %i[show update destroy]

  # GET /hits
  def index
    param! :amount, Integer
    param! :next_token, String

    result = MturkService.list_hits(params)

    respond_with ListHitsResponseSerializer.render(result)
  end

  # GET /hits/1
  def show
    render json: @hit
  end

  # POST /hits
  def create
    param! :title, String, required: true
    param! :description, String, required: true
    param! :reward, Float, required: true
    param! :assignment_duration, Integer, required: true
    param! :lifetime, Integer, required: true

    result = MturkService.create_hit(params)

    # p result

    hash = {
      name: '123123'
    }

    render json: hash.to_json

    # respond_with hash.to_json
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

  def assignments
    param! :hit_id, String, required: true

    hit_id = params[:hit_id]
    result = MturkService.hit_assignments(hit_id)

    p result

    hash = {}

    render json: hash.to_json
  end

  private
end
