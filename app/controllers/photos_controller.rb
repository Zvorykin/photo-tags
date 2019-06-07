# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :update, :destroy]

  # GET /photos
  def index
    search_params = params.except(:action, :controller)

    respond_with PhotosRemoteService.search(search_params)
  end

  # GET /photos/1
  def show
    render json: @photo
  end

  # POST /photos
  def create
    param! :name, String, required: true

    name = params[:name]

    photo = Photo.new(name: name)

    photo.save
    respond_with ImageSerializer.render(photo), status: :created, location: photo
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      render json: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:name)
    end
end
