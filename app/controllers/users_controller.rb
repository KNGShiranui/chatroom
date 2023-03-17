class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user), notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to new_session_path, notice: "User was successfully destroyed."
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id != current_user.id
      # ここでいきなりcurrent_userを使えるのは、sessions_helperがapplication_controllerにincludeされているから
      flash[:notice] = "権限がありません"
      redirect_to user_path(@user)
    end
  end
end
