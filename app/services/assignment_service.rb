# frozen_string_literal: true

module AssignmentService
  class << self
    def submitted_photos
      result = []
      submitted_assignments = search(status: 'submitted')

      submitted_assignments.each do |assignment|
        assignment[:result].each do |key, value|
          photo = PhotosRemoteService.by_ids(key).first
          photo[:assignment] = AssignmentSerializer.render_as_hash(assignment)
                                                   .merge(tags: value)
                                                   .except(:result)
          result << photo
        end
      end

      result
    end

    def search(params = {})
      status = params[:status]&.capitalize

      assignments = Assignment.order_by(submit_time: :asc)
                              .limit(50)
      assignments = assignments.where(status: status) if status.present?
      assignments
    end

    private
  end
end