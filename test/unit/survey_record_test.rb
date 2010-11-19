require 'test_helper'

class SurveyRecordTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert SurveyRecord.new.valid?
  end
end
