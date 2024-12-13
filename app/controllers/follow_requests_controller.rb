class FollowRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    matching_follow_requests = FollowRequest.all
    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    render({ :template => "follow_requests/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_follow_requests = FollowRequest.where({ :id => the_id })
    @the_follow_request = matching_follow_requests.at(0)

    render({ :template => "follow_requests/show" })
  end

  # Create a follow request
  def create
    recipient = User.find(params.fetch("recipient_id"))
    follow_request = current_user.follow_requests.build(recipient: recipient)

    if follow_request.valid?
      follow_request.save
      redirect_to("/", { :notice => "Follow request sent to #{recipient.username}." })
    else
      redirect_to("/", { :alert => follow_request.errors.full_messages.to_sentence })
    end
  end

  # Cancel a pending follow request
  def cancel
    follow_request = current_user.follow_requests.find_by(recipient_id: params.fetch("recipient_id"), status: "pending")

    if follow_request&.destroy
      redirect_to("/", { :notice => "Follow request canceled." })
    else
      redirect_to("/", { :alert => "Unable to cancel follow request." })
    end
  end

  # Unfollow a user
  def destroy
    recipient_id = params[:recipient_id] || params[:id]
    follow_request = current_user.follow_requests.find_by(recipient_id: recipient_id, status: "accepted")
  
    if follow_request&.destroy
      redirect_to "/", notice: "Unfollowed the user successfully."
    else
      redirect_to "/", alert: "Unable to unfollow the user."
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.status = params.fetch("query_status")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/follow_requests/#{the_follow_request.id}", { :notice => "Follow request updated successfully."} )
    else
      redirect_to("/follow_requests/#{the_follow_request.id}", { :alert => the_follow_request.errors.full_messages.to_sentence })
    end
  end
end