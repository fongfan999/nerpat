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
    user == record.user
  end

  def destroy?
    update? || user.is_patron?(record.group)
  end

  def upvote?
    show?
  end

  def downvote?
    show?
  end
end
