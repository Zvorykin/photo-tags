# frozen_string_literal: true

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
    param! :max_assignments, Integer, required: true, min: 1
    param! :hits_amount, Integer, required: true, min: 1
    param! :photos_per_hit, Integer, required: true
    param! :overlap_percentage, Integer, min: 1, max: 100
    param! :tag_presence, :boolean

    # TODO: need to be refactored
    # TAGS
    tags = PhotoTag.all.pluck(:name) || []
    raise 'Tags are empty!' if tags.empty?

    # PHOTOS
    photo_params = {
      packs_amount: params[:hits_amount],
      photos_per_pack: params[:photos_per_hit],
      overlap_percentage: params[:overlap_percentage],
      tag_presence: params[:tag_presence]
    }
    photos_packs = PhotosRemoteService.get_packs(photo_params)

    # HITS
    hits = []
    params[:hits_amount].times do |num|
      question_params = {
        photos: photos_packs[num],
        tags: tags
      }

      hit_params = {
        title: params[:title],
        description: params[:description],
        reward: params[:reward],
        assignment_duration: params[:assignment_duration],
        lifetime: params[:lifetime],
        max_assignments: params[:max_assignments],
        question: QuestionService.new(question_params).question
      }

      result = HitsService.create(hit_params)
      hits << result
    end

    respond_with HitSerializer.render(hits), location: hits_url
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

    MturkService.update_hit_submitted_assignments(params)

    hash = {}

    render json: hash
  end

  private

  def validate_pagination_params
    param! :per_page, Integer
    param! :page, String
  end
end
