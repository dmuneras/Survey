class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      @user = User.find_by_username(@user_session.username)
      flash[:notice] = "Has ingresado exitosamente."
      if @user.username == 'Administrador'
        redirect_to companies_path
      else
         redirect_to @user
      end
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    flash[:notice] = "Vuelve pronto."
    redirect_to root_url
  end
end
