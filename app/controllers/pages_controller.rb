class PagesController < ApplicationController
  def index
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
      @chosen_date = 'Select Date'
      if params[:date]
        selected_date = params[:date]
        @tasks = @current_user.tasks.search(selected_date)
        @chosen_date = selected_date
      else
        @tasks = @current_user.tasks.order('created_at ASC')
      end
    else
      @current_user = nil
      @tasks = nil
    end
  end
end
