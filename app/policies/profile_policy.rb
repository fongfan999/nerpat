class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def show?
    true
  end

  def update?
    user.own?(record)
  end
end
