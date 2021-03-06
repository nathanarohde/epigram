class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def index
    @photos = Photo.all.shuffle
  end

  def show
    @user = User.find(params[:id])
    @photos = @user.photos.all
    @photo = Photo.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Registered successfully!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end



private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :avatar)
  end

end
