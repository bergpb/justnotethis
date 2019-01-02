include BCrypt

def current_user
  User.find(session[:user_id])
end

def user_signed_in?
  session[:user_id].present?
end

# load register template
get '/register' do
  slim :register
end

# save user username and password
post '/register' do
  password = Password.create(params[:password])
  user = User.create(username: params[:username],
                      email: params[:email],
                      password: password)
  unless user.nil?
    flash[:success] = 'User registred.'
    redirect '/login'
  else
    flash[:danger] = 'Fail to save user.'
  end
end

# change user password
get '/change_password' do
  tasks = Task.order(id: :desc)
  slim :list
end