require "klue_lancer/version"
require 'net/http'
require 'json'
require 'oauth2'
require 'faraday'

module KlueLancer
  class Freelancer
    attr_reader :client

    CLIENT_ID = '670b9eb4-beab-4518-9cc4-c7c897fef19e'
    CLIENT_SECRET = '47237cad532f606e0ffa1633fe82c5f37c9292ac9f31bc6b1b2168f911d073ee897106e098e60a6b0202c712075ff985d13aea90b897a1d1607278464c16447a'

    FREELANCER_AUTH_SERVER_URL = 'https://accounts.freelancer-sandbox.com/oauth/authorize'
    FREELANCER_RESOURCE_URL = 'https://www.freelancer-sandbox.com'
    REDIRECT_URL = 'https://damp-scrubland-51985.herokuapp.com/api/v1/freelancers/auth?david=cruwys&jin=cool'

    def initialize
      @client_id = CLIENT_ID
      @client_secret = CLIENT_SECRET
      # Initiate the oAuth authentication processs
      @client = OAuth2::Client.new(@client_id, @client_secret, :site => FREELANCER_AUTH_SERVER_URL )
    end

    def get_token(bearer_token)
      # This is the URL that the user will navigate to with a uniquie client_id and the endpoint on our system that will ultimately receive the code
      redirect_string = @client.auth_code.authorize_url(:redirect_uri => REDIRECT_URL )
      grant_code = redirect_string['code']
      bearer_token || @client.auth_code.get_token(grant_code, :headers =>  {'content-type': 'application/x-www-form-urlencoded'})
    end

    def post_project(bearer_token)
      uri = URI.parse(FREELANCER_RESOURCE_URL)  # returns string
      headers = { 'Content-Type' => 'application/json', 'freelancer-oauth-v1' => get_token(bearer_token) }

      Faraday.new(url: uri).post '/api/projects/0.1/projects/', FIXED_PROJECT_DATA.to_json, headers
      # puts res.to_json
      # handle exceptions here
    end

    def list_project_bids(project_id, bearer_token)
      uri = URI.parse(FREELANCER_RESOURCE_URL)
      headers = { 'Content-Type' => 'application/json', 'freelancer-oauth-v1' => get_token(bearer_token) }
      res = Faraday.new(url: uri).get "/api/projects/0.1/projects/#{project_id}/bids", headers

      JSON.parse(res.body)['result']
      # => {"shortlisted_bids"=>nil, "recommended_bid"=>nil, "expert_guarantees"=>nil, "bids"=>[], "users"=>nil}
    end
  end
end
