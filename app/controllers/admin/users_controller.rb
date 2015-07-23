class Admin::UsersController < ApplicationController

  before_action :require_admin, only: [:index]

  def new
    @user = User.new
  end

 def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
 end

  
end
