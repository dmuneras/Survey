require 'test_helper'

class Username:stringsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Username:string.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Username:string.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    username:string = Username:string.first
    delete :destroy, :id => username:string
    assert_redirected_to root_url
    assert !Username:string.exists?(username:string.id)
  end
end
