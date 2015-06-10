require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: nil
    assert_response 302
  end

end
