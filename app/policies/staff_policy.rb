class StaffPolicy < ApplicationPolicy

  def create?
    if user.admin == true
      true
    else
      false
    end
  end

  def destroy?
    user.admin == true
  end
end
