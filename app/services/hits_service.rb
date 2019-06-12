# frozen_string_literal: true

module HitsService
  class << self
    def search(params)
      Hit.all
    end

    def create(params)
      mturk_hit = MturkService.create_hit(params)

      Hit.create(
        title: params[:title],
        description: params[:description],
        reward: params[:reward],
        assignment_duration: params[:assignment_duration],
        lifetime: params[:lifetime],
        max_assignments: params[:max_assignments],
        hit_id: mturk_hit[:hit_id],
        status: mturk_hit[:hit_status],
        expiration_at: mturk_hit[:expiration],
        payload: mturk_hit.to_h
      )
    end
  end
end