class Admin::UsersController < ApplicationController



  before_filter :restrict_access
  before_action :require_admin, only: [:index]
 
   def index
     @users = User.order(:firstname).page(params[:page]).per(5)
   end

  def new
    @user = User.new
  end

 def create
    @user = User.new(user_params)
    @user.save
    #   session[:user_id] = @user.id
      redirect_to admin_users_path, notice: "Just created new user: #{@user.firstname}!"
    # else
    #   render :new
 end 

 def show
  @user = User.find(params[:id])
 end

   def edit
    @user = User.find(params[:id])
   end

   def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_users_path, notice: "user with user ID '#{@user.id} just got updated!'"
   end

   def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path 
  end


  protected
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin,)
  end
 end


