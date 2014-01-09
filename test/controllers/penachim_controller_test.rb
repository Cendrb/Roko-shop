require 'test_helper'

class PenachimControllerTest < ActionController::TestCase
  test "should get mapa" do
    get :mapa
    assert_response :success
  end

  test "should get fuckoff" do
    get :fuckoff
    assert_response :success
  end

  test "should get rododendron" do
    get :rododendron
    assert_response :success
  end

end
