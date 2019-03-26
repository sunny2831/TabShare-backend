class UsersController < ApplicationController

    def index
      @users = User.all
      render json: @users
    end

    def get_owed_by_tabs
      @user = get_current_user
      # byebug
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

    def get_friends
      @user = get_current_user
      # byebug
      if @user
        render json: @user.friends
      else
        render json: {error: "No friends here"}, status: 401
      end
    end

    def login
      # byebug
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        render json: {username: @user.username, token: issue_token({id: @user.id})}
        # byebug
      else
        render json: {error: "Your username or password is incorrect"}, status: 401
      end
    end

    def validate
      @user = get_current_user
      if @user
        render json: {username: @user.username, token: issue_token({id: @user.id})}
      else
        render json: {error: "Your username or password is incorrect"}, status: 401
      end
    end

    def create
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        render json: {username: @user.username, token: issue_token({id: @user.id})}
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
