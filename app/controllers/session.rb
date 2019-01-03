get '/login' do
  session[:user_id] = nil
  slim :session
end

post '/login' do
  username = params[:username]
  user = User.find_by('username = ?', username)
  unless user.nil?
    if BCrypt::Password.new(user.password) == params[:password]
      session[:user_id] = user.id
      flash[:success] = 'User logged.'
      redirect '/'
    else
      flash[:warning] = 'User or password incorrect.'
      redirect '/login'
    end
  else
    flash[:warning] = 'User or password incorrect.'
    redirect '/login'
  end
end

get '/logout' do
  session[:user_id] = nil
  flash[:info] = 'Please login.'
  redirect '/login'
end
