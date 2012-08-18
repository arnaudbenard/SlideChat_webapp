module BoxHelper

#This is a helper file to communicate with Box API

require 'net/http'
require 'net/https'
require "uri"

  #Function to get ticket (for the login of the user)
  def get_ticket(user)
    @api="" #Insert api key
    #GET request and parsing of the XML response
    uri = URI.parse(URI.encode("https://www.box.com/api/1.0/rest?action=get_ticket&api_key=#{@api}"))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
  	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  	response = http.request(Net::HTTP::Get.new(uri.request_uri))
  	@doc = Nokogiri::XML(response.body)
  	@response=@doc.xpath("/response/ticket").first.content
  	user.update_attributes(ticket: @response)
  	return @response
  end

  #Function to verify the authentification of the user 
  def verify_auth(user)
  	@ticket=user.ticket
    @api="" #Insert api key
    #GET request and parsing of the XML response
  	uri = URI.parse(URI.encode("https://www.box.com/api/1.0/rest?action=get_auth_token&api_key=#{api}&ticket=#{@ticket}"))
  	http = Net::HTTP.new(uri.host, uri.port)
  	http.use_ssl = true
  	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  	response = http.request(Net::HTTP::Get.new(uri.request_uri))
  	@doc = Nokogiri::XML(response.body)
  	@response=@doc.xpath("/response/auth_token").first.content
  	user.update_attributes(auth: @response)
  end

  #Function to get the content of some folders
  def get_folder_data(user,folder_name)

    @api="" #Insert api key

    #These folders are already created on box manually
    #This part should be edited for your project (create your own folder, share them on box and insert the folders id below)
  	if folder_name == "#explore"
  		folder="351101959" #Folder "#explore" id on my box account (to edit)
  	elsif folder_name == "#web"
  		folder = "351082569"
  	elsif folder_name =="#iphone"
  		folder="351082493"
  	elsif folder_name == "#android"
  		folder="351082589"
  	elsif folder_name=="#support"
  		folder="351101941"
  	end

  	auth="" #insert auth account key
  	url = URI.parse("https://api.box.com/2.0/folders/#{folder}")
  	req = Net::HTTP::Get.new(url.path)
  	req.add_field("Authorization", "BoxAuth api_key=#{api}&auth_token=#{auth}")
  	http = Net::HTTP.new(url.host, url.port)
  	http.use_ssl = true
  	http.verify_mode = OpenSSL::SSL::VERIFY_NONE	
    response = http.request(req)
  	resp=JSON.parse(response.body)

	@elements=resp["item_collection"]["entries"]

 end

  #Function to get the embedded flash preview HTML snippet
  def get_embedded(user,files)
    auth=""  #insert auth account key
    links = Array.new
    
    files.each do |file|
      @id=file["id"]
      uri = URI.parse(URI.encode("http://box.net/api/1.0/rest?action=create_file_embed&api_key=x0dcfl3a1vjc56j0sg6cytjfm3dt5r05&auth_token=#{auth}&file_id=#{@id}&params%5Ballow_download%5D=0&params%5Ballow_print%5D=0&params%5Ballow_share%5D=0&params%5Bwidth%5D=600&params%5Bheight%5D=600&params%5Bcolor%5D=9E9E9E"))
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
      @doc = Nokogiri::XML(response.body)
      @response=@doc.xpath("/response/file_embed_html").first.content
      links << @response #saves url and name in an array (links)
      links << file["name"]
    end

    @test= links
    return @test
  end

end
