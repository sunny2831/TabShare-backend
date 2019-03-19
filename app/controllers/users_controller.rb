class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def get_owed_by_tabs
    @user = get_current_user
    if @user
      render json: @user.owed_by_tabs
    else
      render json: {error: "Not a valid user"}, status: 401
    end
  end

  def get_owed_to_tabs
    @user = get_current_user
    if @user
      render json: @user.owed_to_tabs
    else
      render json: {error: "Not a valid user"}, status: 401
    end
  end

  def login
    @user = User.find_by(email_address: params[:email_address])
    if @user
      render json: {email_address: @user.email_address, password: @user.password_digest, user_id: @user.id}
    else
      render json: {error: "Your email address or password is incorrect"}, status: 401
    end
  end

  # def validate
  #   @user = get_current_user
  #   if @user
  #     render json: {email_address: @user.email_address, password: @user.password_digest, user_id: @user.id}
  #   else
  #     render json: {error: "Your email address or password is incorrect"}, status: 401
  #   end
  # end

  def create
    @user = User.new(username: params[:username], email_address: params[:email_address], password: params[:password])
    if @user.save
      render json: @user
    else
      render json: {error: "Unable to create user"}, status: 401
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: @user
    else
      render json: {error: "no such user found"}, status: 401
    end
  end

end
