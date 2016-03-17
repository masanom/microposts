class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update, :following, :follower]
  before_action :collect_user, only:[:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcom to Samle App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報を編集しました'
    else
      render 'edit'
    end
  end
  
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following_users.page(params[:page])
    render 'show_follow'
  end
  def follower
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users.page(params[:page])
    render 'show_follow'
  end
  

  
  private
  def user_params
    params.require(:user).permit(:name, :email, :address, :profile, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def collect_user
    @user = User.find(params[:id])
    redirect_to(root_url) if @user != current_user
  end
end
