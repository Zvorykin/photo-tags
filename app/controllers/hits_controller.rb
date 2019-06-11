class HitsController < ApplicationController
  # before_action :set_hit, only: %i[show update destroy]

  # GET /hits
  def index
    validate_pagination_params

    result = HitsService.search(params).to_a

    respond_with HitSerializer.render(result, root: :hits)
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
    param! :max_assignments, Integer, required: true

    result = HitsService.create(params)

    respond_with result
    # respond_with HitSerializer.render(result.to_a)
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
    validate_pagination_params
    param! :hit_id, String, required: true
    param! :assignment_statuses, String, in: %w[submitted approved rejected]

    result = MturkService.hit_submitted_assignments(params)

    respond_with ListHitAssignmentsResponseSerializer.render(result),
                 location: hits_url
  end

  def update_assignments
    param! :hit_id, String, required: true

    result = MturkService.update_hit_submitted_assignments(params)

    hash = {}

    render json: hash
  end

  private

  def validate_pagination_params
    param! :per_page, Integer
    param! :page, String
  end
end
