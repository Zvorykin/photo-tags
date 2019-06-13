# frozen_string_literal: true

module AssignmentService
  class << self
    def submitted_photos
      result = []
      submitted_assignments = search(status: 'submitted')

      submitted_assignments.each do |assignment|
        assignment[:answers].each do |item|
          photo = PhotosRemoteService.by_ids(item[:photo_id]).first
          photo[:assignment] = AssignmentSerializer
                               .render_as_hash(assignment)
                               .merge(tags: item[:tags])
                               .except(:answers)
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

    def upsert_result(params)
      assignment = Assignment.find_by(assignment_id: params[:assignment_id])

      assignment.results
                .delete_if { |result| result[:image_id] == params[:image_id] }
                .append(
                  image_id: params[:image_id],
                  tags: params[:tags]
                )

      assignment.save
    end
  end
end