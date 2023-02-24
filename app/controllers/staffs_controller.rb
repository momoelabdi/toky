class StaffsController < ApplicationController

    def create
        @staff = Staff.new(staff_params)
        authorize @staff, :create?
        if @staff.save
            redirect_to @staff
        else
        flash[:alert] = "You are not authorized to create a new staff member.", stautus: :unauthorized
        end
    end


    def destroy
        @staff = Staff.find(params[:id])
        authorize @staff, :destroy?
        @staff.destroy
        redirect_to root_path
    end


    private
    def staff_params
        params.require(:staff).permit(:name, :email, :role, :password, :password_confirmation)
    end
end
