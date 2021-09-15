class RecordsController < ApplicationController
  def create
    @record = Record.new(record_params)
    @record.start_time = Date.today
    @record.save
    redirect_to users_my_page_path(current_user.id)
  end

  private
  def record_params
    params.require(:record).permit(:coordinate_id, :start_time)
  end

end
