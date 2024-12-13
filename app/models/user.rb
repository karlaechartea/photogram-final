# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :follow_requests, foreign_key: :sender_id
         has_many :received_follow_requests, foreign_key: :recipient_id, class_name: "FollowRequest"
       
         def following?(other_user)
           follow_requests.exists?(recipient_id: other_user.id, status: "accepted")
         end
       
         def pending_follow_request?(other_user)
           follow_requests.exists?(recipient_id: other_user.id, status: "pending")
         end
end
