class SessionsController < ApplicationController

  def create
    #
    @user = User.find_by_credentials(params[:email], params[:password])
    if @user
      log_in(@user)
      render "api/users/show"
    else
      render json: ["Invalid username/password combination"], status: 401
    end
  end

  def destroy
    logout
    if !get_current_user
      render json: {}
    else
      render json: ["No user currently signed in"], status: 404
    end
  end

  def show
    @user = get_current_user
    render 'api/users/show'
  end

end
