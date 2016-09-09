require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: 'italy-pisa-test'
    assert_response 200
  end

end
