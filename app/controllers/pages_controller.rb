class PagesController < ApplicationController
	#before_filter :authenticate_user!, :only => [:login]

  def index
   @session = OTSDK.create_session('127.0.0.1')
   @token = OTSDK.generate_token :session_id => @session, :role => OpenTok::RoleConstants::PUBLISHER, :connection_data => "username=Bob,level=4"
  end

def login
	  @user = current_user
	  respond_to do |format|
	  format.html {render :text => "#{@user.id}"} 
	  format.xml {render :text => "#{@user.id}" }   
 	end
end

end
