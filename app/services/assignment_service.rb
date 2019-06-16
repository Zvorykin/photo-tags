# frozen_string_literal: true

module AssignmentService
  class << self
    def submitted_photos(params = {})
      photos = []
      submitted_assignments = search(status: 'submitted')

      submitted_assignments.each do |assignment|
        assignment[:answers].each do |item|
          next if assignment[:results].any? do |result|
            result[:photo_id] == item[:photo_id]
          end

          photos << {
            photo_id: item[:photo_id],
            assignment_id: assignment[:assignment_id],
            assignment_tags: item[:tags].sort
          }
        end
      end

      photos.take(params[:limit] || 50)
            .map do |photo|
        remote_photo = PhotosRemoteService.by_ids(photo[:photo_id]).first
        remote_photo.merge(photo)
      end
    end

    def search(params = {})
      status = params[:status]&.capitalize

      assignments = Assignment.order_by(submit_time: :asc)
                              .limit(50)
      assignments = assignments.where(status: status) if status.present?
      assignments
    end

    def upsert_result(params)
      photo_id = params[:photo_id]
      new_result = {
        photo_id: photo_id,
        tags: params[:tags]
      }

      PhotosRemoteService.upsert_tags(new_result)

      assignment = Assignment.find_by!(assignment_id: params[:assignment_id])
      assignment.results
                .delete_if { |result| result[:photo_id] == photo_id }
                .append(new_result)

      assignment[:status] = 'Approved' \
        if assignment[:answers].size == assignment[:results].size

      assignment.save!

      # TODO: need to be refactored
      related_hit = Hit.find_by!(hit_id: assignment[:hit_id])
      approved_hit_assignments = Assignment.where(
        hit_id: assignment[:hit_id],
        status: 'Approved'
      )

      if related_hit[:max_assignments] == approved_hit_assignments.size
        related_hit[:status] = 'Unassignable'
        related_hit.save!
      end
    end
  end
end