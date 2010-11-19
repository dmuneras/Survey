require 'test_helper'

class SurveyRecordsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => SurveyRecord.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    SurveyRecord.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    SurveyRecord.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to survey_record_url(assigns(:survey_record))
  end
  
  def test_edit
    get :edit, :id => SurveyRecord.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    SurveyRecord.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SurveyRecord.first
    assert_template 'edit'
  end

  def test_update_valid
    SurveyRecord.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SurveyRecord.first
    assert_redirected_to survey_record_url(assigns(:survey_record))
  end
  
  def test_destroy
    survey_record = SurveyRecord.first
    delete :destroy, :id => survey_record
    assert_redirected_to survey_records_url
    assert !SurveyRecord.exists?(survey_record.id)
  end
end
