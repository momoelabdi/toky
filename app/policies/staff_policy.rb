class StaffPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.admin? == true
  end

  def destroy?
    user.admin? == true
  end

  def new
    create?
  end




end