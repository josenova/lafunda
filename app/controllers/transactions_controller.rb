class TransactionsController < ApplicationController

  require "uri"
  require "net/http"

  def deposit

    #uri = URI.parse("http://http://190.4.89.56//Pages/frmLogin.aspx")

# Shortcut
    #@mnet_response = Net::HTTP.post_form(uri, {"CustPIN" => "KINBAR", "Password" => "PASSFF321", "Frontend_ID" => "1", "Language" => "EN" })

# Full control
    #http = Net::HTTP.new(uri.host, uri.port)
    #request = Net::HTTP::Post.new(uri.request_uri)
    #request.set_form_data({"q" => "My query", "per_page" => "50"})

# Tweak headers, removing this will default to application/x-www-form-urlencoded
    #request["Content-Type"] = "application/json"

    #@mnet_response = http.request(request)

  end

  def withdraw
  end

end
