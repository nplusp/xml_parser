class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Returns array of hashes with history of changed fields
  #   if audits plugin is added in to model
  def changes
    return unless respond_to?(:audits)
    audits.each_with_object([]) do |audit, versions|
      versions << audit.audited_changes.merge!("changed_at" => audit.created_at)
    end
  end
end
