module BoxHelper

require 'net/http'
require 'net/https'
require "uri"


  def get_ticket(user)
  	uri = URI.parse(URI.encode("https://www.box.com/api/1.0/rest?action=get_ticket&api_key=x0dcfl3a1vjc56j0sg6cytjfm3dt5r05"))
  	http = Net::HTTP.new(uri.host, uri.port)
  	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	response = http.request(Net::HTTP::Get.new(uri.request_uri))
	@doc = Nokogiri::XML(response.body)
	@response=@doc.xpath("/response/ticket").first.content
	user.update_attributes(ticket: @response)
	return @response
  end

  def verify_auth(user)
  	@ticket=user.ticket
  	uri = URI.parse(URI.encode("https://www.box.com/api/1.0/rest?action=get_auth_token&api_key=x0dcfl3a1vjc56j0sg6cytjfm3dt5r05&ticket=#{@ticket}"))
  	http = Net::HTTP.new(uri.host, uri.port)
  	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	response = http.request(Net::HTTP::Get.new(uri.request_uri))
	@doc = Nokogiri::XML(response.body)
	@response=@doc.xpath("/response/auth_token").first.content
	user.update_attributes(auth: @response)
  end
end
