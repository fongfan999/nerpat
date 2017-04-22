class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.group.has_member?(user)
  end

  def create?
    show?
  end

  def update?
    user.is_author?(record)
  end

  def destroy?
    user.is_author?(record) || user.is_patron?(record.group)
  end

end
