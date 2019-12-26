# frozen_string_literal: true

route :get, :post, '/login' do
  method = request.env['REQUEST_METHOD']
  if method == 'GET'
    if user_signed_in?
      redirect '/'
    else
      slim :"user/login"
    end
  elsif method == 'POST'
    user = User.find_by('username = ?', params[:username])
    auth_user = user.authenticate(params[:password])
    if user && auth_user
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.username}."
      redirect '/'
    else
      flash[:warning] = 'User or password incorrect.'
      redirect '/login'
    end
  end
end

get '/logout' do
  session[:user_id] = nil
  flash[:info] = 'Please login.'
  redirect '/login'
end
