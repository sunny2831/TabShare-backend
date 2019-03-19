class FriendshipsController < ApplicationController

  def create
    @user = get_current_user
    @friendship = Friendship.new(user1_id: params[:user1_id], user2_id: params[:user2_id])
    if @friendship.save
      render json: @friendship
    else
      render json: {error: "Sorry no friendship made"}, status: 401
    end
  end

  def destroy
  end

  def show
    @friendship = Friendship.find_by(user1_id: get_current_user.id, user2_id: params[:id]) || Friendship.find_by(user1_id: params[:id], user2_id: get_current_user.id)
  end

end
