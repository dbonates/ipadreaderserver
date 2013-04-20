require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def should_be_admin
    u = users(:admin)
    assert u.admin?, "Admin deve ser admin, ora bolas!"
  end
end
