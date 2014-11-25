require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'rack/test'
require 'rubygems'
require 'rspec'
require 'test/unit'
require 'minitest/autorun'

include Rack::Test::Methods

   def app
      Sinatra::Application
   end
describe "Testing specs" do
    
    it "Sin iniciar session" do
       get '/', {}, 'rack.session' => { :name => 'Testing' }
       expect(last_response).to be_ok
    end
    
    it "Con usuario" do
       get '/'
       expect(last_response).to be_ok
    end
    
    it "Testing post" do
       post '/'
       expect(last_response).to be_ok
    end
    
    it "Logout" do
       get '/logout'
       expect(last_response).to be_ok
    end
    
    it "Update" do
       get'/update'
       expect(last_response.body).to eq("Not an ajax request")
    end
	
	it "Get user" do
	    get '/user'
	    expect(last_response.body).to eq("Not an ajax request")
	end
 end