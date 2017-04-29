class VotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    update?
  end

  def update?
    record.group.has_member?(user)
  end
end
