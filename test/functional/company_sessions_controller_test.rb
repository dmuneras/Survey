require 'test_helper'

class CompanySessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    CompanySession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    CompanySession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    company_session = CompanySession.first
    delete :destroy, :id => company_session
    assert_redirected_to root_url
    assert !CompanySession.exists?(company_session.id)
  end
end
