require 'sinatra' 
require 'sinatra/reloader' if development?
#set :port, 3000
#set :environment, :production

enable :sessions
set :session_secret, '*&(#234a)'


chat = ['welcome..']
user = Array.new()

get '/' do
  if !session[:name]
    erb :login
  else
    erb :chat
  end
end

post '/' do

  if (user.include?(param[:username]))
    redirect '/'
  else
    name = params[:username]
    session[:name] = name
    user << name
    puts user
    erb :index
  end
end


get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:name]} : #{params['text']}"
  nil
end

get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []

  @last = chat.size
  erb <<-'HTML', :layout => false
      <% @updates.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
      <span data-last="<%= @last %>"></span>
  HTML
end


