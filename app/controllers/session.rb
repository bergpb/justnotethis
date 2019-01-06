get '/login' do
  if user_signed_in?
    redirect '/'
  else
    slim :session
  end
end

post '/login' do
  user = User.find_by('username = ?', params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'User logged.'
      redirect '/'
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
