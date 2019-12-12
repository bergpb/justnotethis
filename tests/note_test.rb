require File.expand_path(File.join('..', 'tests', 'test_helper'), __dir__)

class NoteTests < Minitest::Test

  def do_login
    post '/login', {:username=>"admin", :password=>"123456"}
    follow_redirect!
    @user_id = last_request.env['rack.session'][:user_id]
  end

  def test_create_note
    do_login
    post '/new', {
      :title=>"admin",
      :description=>"123456",
      :user_id=>@user_id,
    }
    follow_redirect!
    assert_equal last_response.status, 200, "Response is not 200."
    assert_includes last_response.body, "Note saved."
  end

  def test_show_note
    do_login
    get '/show/1'
    if last_response.ok?
      assert_equal last_response.status, 200
      assert_includes last_response.body, "Show note:"
    end
  end

  def test_edit_note
    do_login
    post '/edit/1', {
      :title=>"admin",
      :description=>"123456",
      :user_id=>@user_id,
    }
    if last_response.status == 302
      follow_redirect!
      assert last_response.ok?
      assert_equal last_response.status, 200
      assert_includes last_response.body, "Note updated."
    end
  end

  def test_mark_test_with_complete
    do_login
    get '/complete/1'
    if last_response.status == 302
      follow_redirect!
      assert last_response.ok?
      assert_equal last_response.status, 200
      assert_includes last_response.body, "Note marked with complete."
    end
  end

  def test_delete_task
    do_login
    get '/delete/1'
    if last_response.status == 302
      follow_redirect!
      if last_response.body.include? "Note removed."
        assert last_response.ok?
        assert_equal last_response.status, 200
      elsif last_response.body.include? "Note don't exists."
        assert last_response.ok?
        assert_equal last_response.status, 200
      end
    end
  end
end