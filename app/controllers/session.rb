get '/login' do
  session[:user_id] = nil
  slim :session
end

post '/login' do
  username = params[:username]
  @user = User.find_by('username = ?', username)
  unless @user.nil?
    if Password.new(@user.password) == params[:password]
      flash[:success] = 'User logged.'
      session[:user_id] = @user.id
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
  session[:user_id] = nil
  redirect '/login'
end