require 'sinatra'

get '/contact' do 
  erb :contact
end

post '/contact' do 
  require 'pony'
  Pony.mail(
    :from => params[:name] + "<" + params[:email] + ">",
    :to => 'username@gmail.com',
    :subject => params[:name] + " has contacted you",
    :body => params[:message],
    :port => '587',
    :via => :smtp,
    :via_options => { 
      :address              => 'smtp.gmail.com', 
      :port                 => '587', 
      :enable_starttls_auto => true, 
      :user_name            => 'username', 
      :password             => 'password', 
      :authentication       => :plain, 
      :domain               => 'localhost.localdomain'
    }
  )
  redirect '/success' 
end

get('/success'){"Thanks for your email. We'll be in touch soon."}
