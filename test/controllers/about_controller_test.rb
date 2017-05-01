require File.dirname(__FILE__) + '/../test_helper'

class AboutControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
    assert_template 'about/index'
    assert_equal 'Sobre UCASport', assigns(:page_title)
    assert_select 'title', 'Sobre UCASport'
    assert_select 'h1', 'Sobre UCASport'
  end
end
