require 'test_helper'

class SubsectorTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Subsector.new.valid?
  end
end
