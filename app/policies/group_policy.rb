class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.has_member?(user)
  end

  def update?
    user.is_patron?(record)
  end
end
