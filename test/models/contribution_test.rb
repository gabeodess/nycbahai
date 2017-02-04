require 'test_helper'

class ContributionTest < ActiveSupport::TestCase
  test "name setter" do
    first = Faker::Name.first_name
    last = Faker::Name.last_name
    @contribution = FactoryGirl.create(:contribution, name: [last, first].join(', '))
    assert_equal [first, last].join(' '), @contribution.name
  end
end
