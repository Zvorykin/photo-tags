# frozen_string_literal: true

class AssignmentsController < ApplicationController
  # GET /assignments
  def index
    param! :status, String
    result = AssignmentService.search(params).to_a

    respond_with AssignmentSerializer.render(result)
  end

  # GET /assignments/1
  def show
    # render json: @assignment
  end

  def add_result
    param! :assignment_id, String, required: true
    param! :image_id, String, required: true
    param! :applied, :boolean, required: true
    param! :tags, Array do |array, index|
      array.param! index, String, required: true
    end

    AssignmentService.upsert_result(params)
  end
end
