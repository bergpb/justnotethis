require File.expand_path(File.join('..', 'tests', 'test_helper'), __dir__)

class RegisterTests < Minitest::Test
  def test_get_register
    get '/register'
    assert_equal last_response.status, 200
    assert_includes last_response.body, 'Register'
  end

  def test_success_register
    post '/register', username: 'admin1',
                      email: 'admin1@gmail.com',
                      password: 'admin1234',
                      check_password: 'admin1234'
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:success],
                 'User registred.'
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_register_passwords_dont_match
    post '/register', username: 'admin1',
                      email: 'admin1@gmail.com',
                      password: 'admin1234',
                      check_password: 'admin4321'
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:danger],
                 "Passwords don't match."
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_register_errors
    post '/register', username: 'admin',
                      email: 'admin@gmail.com',
                      password: '123456',
                      check_password: '654321'
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:danger],
                 "Passwords don't match."
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end
end
