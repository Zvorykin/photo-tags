# frozen_string_literal: true

class PhotosController < ApplicationController
  # GET /photos
  def index
    respond_with PhotosRemoteService.search(photo_params)
    # respond_with PhotosRemoteService.get_bulk(150, photo_params)
  end

  # GET /photos/1
  def show
    respond_with PhotosRemoteService.by_ids(params[:id])
  end

  private

  def photo_params
    params.except(:action, :controller, :format, :photo)
  end
end
