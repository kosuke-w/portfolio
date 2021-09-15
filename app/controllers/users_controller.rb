class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)

    @records = Record.all

    gon.push({
    :address => @user.address,
    :key => ENV['OPEN_WEATHER_MAP_API']
  })
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_my_page_path(current_user.id)
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_active: User.is_active.key(false))
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :image_id, :sex, :introduction, :email, :password, :address, :is_active)
  end
end
