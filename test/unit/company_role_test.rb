require 'test_helper'

class CompanyRoleTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CompanyRole.new.valid?
  end
end
