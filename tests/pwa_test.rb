require File.expand_path(File.join('..', 'tests', 'test_helper'), __dir__)

class PWATests < Minitest::Test
  def test_sw
    get '/sw.js'
    assert last_response.ok?
    assert_equal last_response.status, 200
    assert_includes last_response.body, 'Yay! Workbox is loaded'
  end

  def test_manifest
    get '/manifest.json'
    assert last_response.ok?
    assert_equal last_response.status, 200
    assert_includes last_response.body, 'Simple web app to control notes.'
  end
end
