class RelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
  end
  
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
  end
  
  def follows
    @user = User.find(params[:user_id])
    @users = @user.following_users
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.follower_users
  end
  
end
