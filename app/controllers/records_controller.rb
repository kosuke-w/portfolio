class RecordsController < ApplicationController
  def create
    @record = Record.new(record_params)
    @record.start_time = Date.current
    if @record.save
      flash[:notice] = '登録しました'
      redirect_to my_page_user_path(current_user.id)
    else
      flash[:notice] = '既に登録しています'
      redirect_to my_page_user_path(current_user.id)
    end
  end

  def destroy
    record = Record.find(params[:id])
    record.destroy
    flash[:notice] = '解除しました'
    redirect_to my_page_user_path(current_user.id)
  end

  private

  def record_params
    params.require(:record).permit(:coordinate_id, :start_time)
  end
end
