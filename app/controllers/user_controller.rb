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
  if params[:password] == params[:check_password]
    user = User.new(username: params[:username],
                    email: params[:email],
                    password: params[:password])
    if user.save
      flash[:success] = 'User registred.'
      redirect '/login'
    else
      flash[:warning] = 'Check form data.'
      redirect '/register'
    end
  else
    flash[:danger] = 'Passwords don\'t match.'
    redirect '/register'
  end
end

get '/forgot_password' do

end