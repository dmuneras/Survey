require 'test_helper'

class CompanyRolesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => CompanyRole.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    CompanyRole.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    CompanyRole.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to company_role_url(assigns(:company_role))
  end
  
  def test_edit
    get :edit, :id => CompanyRole.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    CompanyRole.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CompanyRole.first
    assert_template 'edit'
  end

  def test_update_valid
    CompanyRole.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CompanyRole.first
    assert_redirected_to company_role_url(assigns(:company_role))
  end
  
  def test_destroy
    company_role = CompanyRole.first
    delete :destroy, :id => company_role
    assert_redirected_to company_roles_url
    assert !CompanyRole.exists?(company_role.id)
  end
end
