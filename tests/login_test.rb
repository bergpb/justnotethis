require File.expand_path(File.join('..', 'tests', 'test_helper'), __dir__)

class LoginTests < Minitest::Test

  def test_login
    get '/login'
    assert last_response.ok?
    assert_equal last_response.status, 200
    assert_includes last_response.body, "Login"
  end

  def test_login_success
    post '/login', params={"username"=>"admin", "password"=>"123456"}
    follow_redirect!
    assert_equal last_response.status, 200
    assert_includes last_response.body, "User logged."
  end

  def test_login_failed
    post '/login', params={"username"=>"admin", "password"=>"admin"}
    follow_redirect!
    assert_equal last_response.status, 200
    assert_includes last_response.body, "User or password incorrect."
  end
end