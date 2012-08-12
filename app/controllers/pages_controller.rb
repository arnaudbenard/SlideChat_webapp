class PagesController < ApplicationController
  def index
   @session = OTSDK.create_session('127.0.0.1')
   @token = OTSDK.generate_token :session_id => @session, :role => OpenTok::RoleConstants::PUBLISHER, :connection_data => "username=Bob,level=4"
  end
end
