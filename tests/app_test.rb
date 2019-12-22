require File.expand_path(File.join('..', 'tests', 'test_helper'), __dir__)

class IndexTests < Minitest::Test
  def test_index_page_get
    get '/'
    assert last_response.ok?
    assert_equal last_response.status, 200
    assert_includes last_response.body, 'Hello to JustNoteThis!'
  end

  def test_not_found_status
    get '/test'
    assert !last_response.ok?
    assert_equal last_response.status, 404
    assert_includes last_response.body, 'Ops! Not Found'
  end
end
