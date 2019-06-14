# frozen_string_literal: true

module AssignmentService
  class << self
    def submitted_photos
      photos = []
      submitted_assignments = search(status: 'submitted')

      submitted_assignments.each do |assignment|
        assignment[:answers].each do |item|
          next if assignment[:results].any? do |result|
            result[:photo_id] == item[:photo_id]
          end

          photo = PhotosRemoteService.by_ids(item[:photo_id]).first
          photo[:assignment_id] = assignment[:assignment_id]
          photo[:assignment_tags] = item[:tags].sort

          photos << photo
        end
      end

      photos
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
                .delete_if { |result| result[:photo_id] == params[:photo_id] }
                .append(
                  photo_id: params[:photo_id],
                  tags: params[:tags]
                )

      assignment.save
    end
  end
end