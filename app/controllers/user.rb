def current_user
  User.find_by_id(session[:user_id])
end

def user_signed_in?
  session[:user_id].present?
end

get '/register' do
  slim :register
end

post '/register' do
  password = BCrypt::Password.create(params[:password])
  user = User.new(username: params[:username],
                     email: params[:email],
                     password: password)
  if user.save
    flash[:success] = 'User registred.'
    redirect '/login'
  else
    flash[:danger] = 'Fail to save user.'
  end
end

get '/change_password' do
  tasks = Task.order(id: :desc)
  slim :list
end