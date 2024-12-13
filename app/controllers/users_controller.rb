class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    matching_users = User.all

    @users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index" })
  end

  def show
    the_username = params.fetch("username")
    matching_users = User.where({ username: the_username })
  
    @the_user = matching_users.first
  
    if @the_user.nil?
      redirect_to "/users", alert: "User not found."
    else
      render({ template: "users/show" })
    end
  end

  def create
    the_user = User.new
    the_user.username = params.fetch("query_username")
    the_user.comments_count = params.fetch("query_comments_count")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.private = params.fetch("query_private", false)

    if the_user.valid?
      the_user.save
      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/users", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.username = params.fetch("query_username")
    the_user.comments_count = params.fetch("query_comments_count")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.private = params.fetch("query_private", false)

    if the_user.valid?
      the_user.save
      redirect_to("/users/#{the_user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{the_user.id}", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end
end
