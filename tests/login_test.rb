require File.expand_path(File.join('..', 'tests', 'test_helper'), __dir__)

class LoginTests < Minitest::Test
  def test_login
    get '/login'
    assert last_response.ok?
    assert_equal last_response.status, 200
    assert_includes last_response.body, 'Login'
  end

  def test_login_success
    post '/login', username: 'admin', password: '123456'
    assert_equal last_response.status, 302
    assert_includes last_request.env['rack.session'][:flash][:success],
                    'Welcome back'
    follow_redirect!
    assert_equal last_response.status, 200
  end

  def test_login_failed
    post '/login', username: 'admin', password: 'admin'
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:warning],
                    'User or password incorrect.'
    follow_redirect!
    assert_equal last_response.status, 200
  end
end
