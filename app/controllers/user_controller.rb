route :get, :post, '/register' do
  method = request.env['REQUEST_METHOD']
  if method == 'GET'
    slim :"user/register", locals: {errors: nil}
  elsif method == 'POST'
    if params[:password] == params[:check_password]
      user = User.new(username: params[:username],
                      email: params[:email],
                      password: params[:password])
      if user.save
        flash[:success] = 'User registred.'
        redirect '/login'
      else
        slim :"user/register", locals: {errors: user.errors}
      end
    else
      flash[:danger] = "Passwords don't match."
      redirect '/register'
    end
  end
end
