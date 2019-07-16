require 'test_helper'

class InstaFollowerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get insta_follower_index_url
    assert_response :success
  end

end
