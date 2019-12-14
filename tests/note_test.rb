require File.expand_path(File.join('..', 'tests', 'test_helper'), __dir__)

class NoteTests < Minitest::Test
  def do_login
    post '/login', username: 'admin', password: '123456'
    follow_redirect!
    @user_id = last_request.env['rack.session'][:user_id]
  end

  def create_note
    post '/new', title: 'admin',
                 description: '123456',
                 user_id: @user_id
  end

  def return_id
    @id_note = $id_notes.sample
    $id_notes -= [@id_note]
    return @id_note
  end

  def test_create_note
    do_login
    create_note
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:success],
                 'Note saved.'
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_show_note
    do_login
    get "/show/#{return_id}"
    assert last_response.ok?
    assert_equal last_response.status, 200, 'Response is not 200'
    assert_includes last_response.body, 'Show note:'
  end

  def test_not_found_show_note
    do_login
    get '/show/12'
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:warning],
                 "Note don't exists."
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_search_in_notes_get
    do_login
    get '/search'
    follow_redirect!
    assert last_response.ok?
    assert_equal last_response.status, 200, 'Response is not 200'
    assert_includes last_response.body, 'Nothing to search.'
  end

  def test_search_in_notes_post
    do_login
    post '/search', search: 'jess'
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_edit_note
    do_login
    post "/edit/#{return_id}", title: 'admin',
                               description: '123456',
                               user_id: @user_id
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:success],
                 'Note updated.'
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_edit_note_not_found
    do_login
    post '/edit/12', title: 'admin',
                     description: '123456',
                     user_id: @user_id
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:warning],
                 "Note don't exists."
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_note_mark_with_complete
    do_login
    get "/complete/#{return_id}"
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:success],
                 'Note marked with complete.'
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_not_found_note_mark_with_complete
    do_login
    get '/complete/12'
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:warning],
                 "Note don't exists."
    follow_redirect!
    assert_equal last_response.status, 200, 'Response is not 200'
  end

  def test_delete_task
    do_login
    get "/delete/#{return_id}"
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:success],
                 'Note removed.'
    follow_redirect!
    assert_equal last_response.status, 200
  end

  def test_not_found_on_delete_task
    do_login
    get '/delete/12'
    assert_equal last_response.status, 302
    assert_equal last_request.env['rack.session'][:flash][:warning],
                 "Note don't exists."
    follow_redirect!
    assert_equal last_response.status, 200
  end
end
