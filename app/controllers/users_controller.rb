class UsersController < ApplicationController
	include BoxHelper

  before_filter :authenticate_user!

  def show
  	@user = User.find(params[:id])
  end

  def find_ticket
    #Get ticket of the user and redirect to user page
  	@user = User.find(params[:id])
    get_ticket(@user)
    redirect_to user_path(@user)
  end

  def auth
    #Verify auth of the user and redirect to user page
  	@user = User.find(params[:id])
  	verify_auth(@user)
  	redirect_to user_path(@user)
  end

end