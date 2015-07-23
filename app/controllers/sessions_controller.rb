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


end


