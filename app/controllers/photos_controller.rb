# frozen_string_literal: true

class PhotosController < ApplicationController
  # GET /photos
  def index
    photos_response = PhotosRemoteService.search(photo_params)
    submitted_photos = AssignmentService.submitted_photos

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
    params.except(:action, :controller)
  end
end
