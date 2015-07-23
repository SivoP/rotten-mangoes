class SessionsController < ApplicationController
  before_action :require_admin, only: [:index]

  def new
  end

  def index
    "abc"
  end
 
 def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        render 'layouts/admin'
      else
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
      end
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end 
 end


def destroy
  session[:user_id] = nil
  redirect_to movies_path, notice: "Adios!"
end


def check_for_admin_redirect
  if user.admin?
    render 'layouts/admin'
  else
    redire_to movies_path
  end
end

def preview_mode
  if session[:admin_id].nil? 
    session[:admin_id] =  session[:user_id]
    session[:user_id] = params[:id]
    redirect_to movies_path
  else
    session[:user_id] = session[:admin_id]
    session[:admin_id] = nil
    redirect_to admin_users_path
  end

   # if @current_user.admin?
   #    session[:user_id] = session[:preview_id]
   #    redirect_to movies_path, notice: "You're previewing #{}"
   #  else
    # end
end


  helper_method :switch_to_preview

end


