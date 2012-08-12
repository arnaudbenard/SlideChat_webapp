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

  def get_folder_data(user,folder_name)

  	if folder_name == "#explore"
  		folder="351101959"
  	elsif folder_name == "#web"
  		folder = "351082569"
  	elsif folder_name =="#iphone"
  		folder="351082493"
  	elsif folder_name == "#android"
  		folder="351082589"
  	elsif folder_name=="#support"
  		folder="351101941"
  	end
  	auth="fkb12xhpz15ktzict2a8j5g4q0p60zmf"
  	url = URI.parse("https://api.box.com/2.0/folders/#{folder}")
	req = Net::HTTP::Get.new(url.path)
	req.add_field("Authorization", "BoxAuth api_key=x0dcfl3a1vjc56j0sg6cytjfm3dt5r05&auth_token=#{auth}")
	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE	
  	response = http.request(req)
	resp=JSON.parse(response.body)

	@elements=resp["item_collection"]["entries"]

 end

  def get_embedded(user,files)
  	@id=files.first["id"]
  	auth="fkb12xhpz15ktzict2a8j5g4q0p60zmf"

  	uri = URI.parse(URI.encode("http://box.net/api/1.0/rest?action=create_file_embed&api_key=x0dcfl3a1vjc56j0sg6cytjfm3dt5r05&auth_token=#{auth}&file_id=#{@id}&params%5Ballow_download%5D=0&params%5Ballow_print%5D=0&params%5Ballow_share%5D=0&params%5Bwidth%5D=600&params%5Bheight%5D=600&params%5Bcolor%5D=9E9E9E"))
  	http = Net::HTTP.new(uri.host, uri.port)
	response = http.request(Net::HTTP::Get.new(uri.request_uri))
	@doc = Nokogiri::XML(response.body)
	@response=@doc.xpath("/response/file_embed_html").first.content
  	
  end
end
