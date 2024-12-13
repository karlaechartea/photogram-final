class PhotosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @list_of_photos = Photo.order(created_at: :desc)
    render(template: "photos/index")
  end

  def show
    @the_photo = Photo.find_by(id: params[:path_id])
    render(template: "photos/show")
  end

  def create
    the_photo = Photo.new
    the_photo.caption = params[:query_caption]
    the_photo.comments_count = params[:query_comments_count] || 0
    the_photo.likes_count = params[:query_likes_count] || 0
    the_photo.owner_id = current_user.id if user_signed_in?
    the_photo.image = params[:image]

    if the_photo.save
      redirect_to("/photos", notice: "Photo created successfully.")
    else
      redirect_to("/photos", alert: the_photo.errors.full_messages.to_sentence)
    end
  end

  def update
    the_photo = Photo.find_by(id: params[:path_id])
    the_photo.caption = params[:query_caption]
    the_photo.comments_count = params[:query_comments_count]
    the_photo.likes_count = params[:query_likes_count]
    the_photo.owner_id = current_user.id if user_signed_in?
    the_photo.image = params[:image]

    if the_photo.save
      redirect_to("/photos/#{the_photo.id}", notice: "Photo updated successfully.")
    else
      redirect_to("/photos/#{the_photo.id}", alert: the_photo.errors.full_messages.to_sentence)
    end
  end

  def destroy
    the_photo = Photo.find_by(id: params[:path_id])
    the_photo.destroy
    redirect_to("/photos", notice: "Photo deleted successfully.")
  end
end
