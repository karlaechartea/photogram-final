class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if user_signed_in?
      @users = User.all
      @current_user = current_user
    else
      @users = User.all
    end
  end
end
