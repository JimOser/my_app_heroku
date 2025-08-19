module Creditable
  extend ActiveSupport::Concern

  included do
    has_many :credits, as: :creditable, dependent: :destroy
    has_many :people,  through: :credits
    accepts_nested_attributes_for :credits, allow_destroy: true

    # When a record is newly created, apply any queued role IDs after it has an ID
    after_commit :_apply_pending_credit_roles
  end

  class_methods do
    # Declare role collections + *_ids writers.
    # Example: credit_roles :author
    def credit_roles(*roles)
      roles.each do |r|
        has_many :"#{r}_credits",
                 -> { joins(:role).where(roles: { name: r.to_s }) },
                 as: :creditable, class_name: "Credit", dependent: :destroy

        has_many :"#{r.to_s.pluralize}", through: :"#{r}_credits", source: :person

        define_method("#{r}_ids") { public_send("#{r.to_s.pluralize}").ids }
        define_method("#{r}_ids=") do |ids|
          ids = Array(ids).reject(&:blank?).map!(&:to_i).uniq
          if persisted?
            _sync_credit_role_ids(r, ids)
          else
            @_pending_credit_role_ids ||= {}
            @_pending_credit_role_ids[r.to_s] = ids
          end
        end
      end
    end
  end

  private

  def _apply_pending_credit_roles
    return unless defined?(@_pending_credit_role_ids) && @_pending_credit_role_ids.present?
    @_pending_credit_role_ids.each { |r, ids| _sync_credit_role_ids(r, ids) }
    @_pending_credit_role_ids.clear
  end

  def _sync_credit_role_ids(role_name, ids)
    role  = Role.find_by!(name: role_name.to_s)
    scope = public_send("#{role_name}_credits")
    scope.where.not(person_id: ids).destroy_all
    existing = scope.pluck(:person_id)
    (ids - existing).each { |pid| credits.create!(person_id: pid, role: role) }
  end
end

