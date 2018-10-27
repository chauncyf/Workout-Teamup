require 'test_helper'

class MapControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get map_show_url
    assert_response :success
  end

end
