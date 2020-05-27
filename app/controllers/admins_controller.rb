class AdminsController < ApplicationController
  def create
    @admin = Admin.new(admin_params)
  end
  private
  def admin_params
    params.require(:admin).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
