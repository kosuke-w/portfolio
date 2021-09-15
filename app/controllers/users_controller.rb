class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)

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


    # gom.push({
    #   :address => @user.address,
    #   :apikey => ENV['OPEN_WEATHER_MAP_API']
    # })
    # gom.address
  end

  private
  def user_params
    params.require(:user).permit(:name, :image_id, :sex, :introduction, :email, :password, :address, :is_active)
  end
end
