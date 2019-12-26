# frozen_string_literal: true

get '/' do
  if user_signed_in?
    not_completed_notes = current_user.notes.where(active: true).length
    completed_notes = current_user.notes.where(active: false).length
    username = current_user.username if current_user
  end
  slim :"main/index", locals: {
    not_completed_notes: not_completed_notes,
    completed_notes: completed_notes,
    username: username
  }
end

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

def check_database_type
  case ActiveRecord::Base.connection.adapter_name
  when 'PostgreSQL'
    'ILIKE'
  else
    'LIKE'
  end
end
