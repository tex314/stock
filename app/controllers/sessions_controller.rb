class SessionsController < ApplicationController
  before_filter :authorize, only: [:show]

  def new; end

  def show; end

  def create
    auth = Authentication.new(params)
    if auth.authenticated?
      session[:user_id] = auth.user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Username or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
