class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all
      puts "Users count: #{@users.size}" # Debugging output

  end
end
