get '/login' do
  session[:user_id] = nil
  slim :session
end

post '/login' do
  username = params[:username]
  user = User.find_by('username = ?', username)
  unless user.nil?
    if Password.new(user.password) == params[:password]
      flash[:success] = 'User logged.'
      store(user)
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
  flash[:info] = 'Please login.'
  destroy
  redirect '/login'
end

def store(user)
  session[:user_id] = user.id
end

def destroy
  session[:user_id] = nil
end