class UsersController < ApplicationController
  def my_page
    @user = current_user
    @records = Record.all

    gon.push({
      :address => @user.address,
      :key => ENV['OPEN_WEATHER_MAP_API'],
    })
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'ユーザー情報を更新しました'
      redirect_to my_page_user_path(current_user.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = '退会しました'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :image_id, :sex, :introduction, :email, :password, :address)
  end
end
