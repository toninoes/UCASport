require 'test_helper'

class CheckoutControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get submit_order" do
    get :submit_order
    assert_response :success
  end

  test "should get thank_you" do
    get :thank_you
    assert_response :success
  end

end
