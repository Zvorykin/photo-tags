# frozen_string_literal: true

class SyncAssignmentsWorker
  include Sidekiq::Worker

  def perform
    hits_to_check = Hit.where(status: 'Assignable')

    hits_to_check.each do |hit|
      MturkService.update_hit_submitted_assignments(hit_id: hit[:hit_id])
    end
  end
end
