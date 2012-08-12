class UsersController < ApplicationController
	include BoxHelper

  before_filter :authenticate_user!

  def show
  	@user = User.find(params[:id])

  end

  def find_ticket
  	@user = User.find(params[:id])
    get_ticket(@user)
    redirect_to user_path(@user)

  end

  def auth
  	@user = User.find(params[:id])
  	verify_auth(@user)
  	redirect_to user_path(@user)
  end
end