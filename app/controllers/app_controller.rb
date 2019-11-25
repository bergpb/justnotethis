not_found do
  status 404
  slim :"main/not_found"
end

error 500 do
  status 500
  slim :"main/server_error"
end

def current_user
  User.find_by_id(session[:user_id])
end

def user_signed_in?
  session[:user_id].present?
end