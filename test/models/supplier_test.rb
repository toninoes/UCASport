require 'test_helper'

class SupplierTest < ActiveSupport::TestCase
  test "test_name" do
    supplier = Supplier.create(:first_name => 'Pepe', :last_name => 'Mateo')
    assert_equal 'Pepe Mateo', supplier.name
  end
end
