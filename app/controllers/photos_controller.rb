# frozen_string_literal: true

class PhotosController < ApplicationController
  # GET /photos
  def index
    param! :show_assignments, :boolean

    submitted_photos = params[:show_assignments] ? AssignmentService.submitted_photos : []
    photos_response = PhotosRemoteService.search(photo_params)

    result = {
      photos: submitted_photos.concat(photos_response[:photos]),
      total: photos_response[:total]
    }

    respond_with result
  end

  # GET /photos/1
  def show
    respond_with PhotosRemoteService.by_ids(params[:id])
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      render json: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.except(:action, :controller, :format)
  end
end
