class SessionsController < ApplicationController
  def new
  end

  def create
  	 admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password])
    	session[:admin_id] = admin.id
    	redirect_to supports_path
    else
    flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:admin_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

end
