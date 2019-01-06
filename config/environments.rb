require 'sinatra/activerecord'

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || "postgres://#{ENV['DATA_DB_USER']}:#{ENV['DATA_DB_PASS']}@#{ENV['DATA_DB_HOST']}/#{ENV['DATABASE_NAME']}")
  
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end