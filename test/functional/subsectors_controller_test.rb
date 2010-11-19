require 'test_helper'

class SubsectorsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Subsector.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Subsector.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Subsector.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to subsector_url(assigns(:subsector))
  end
  
  def test_edit
    get :edit, :id => Subsector.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Subsector.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Subsector.first
    assert_template 'edit'
  end

  def test_update_valid
    Subsector.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Subsector.first
    assert_redirected_to subsector_url(assigns(:subsector))
  end
  
  def test_destroy
    subsector = Subsector.first
    delete :destroy, :id => subsector
    assert_redirected_to subsectors_url
    assert !Subsector.exists?(subsector.id)
  end
end
