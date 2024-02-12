# frozen_string_literal: true

require "test_helper"

class TestPropertyPath < Minitest::Test
  include PropertyAccess::PropertyPath

  def test_should_parse_valid_paths
    assert_equal ["root"], parse_property_path("root")
    assert_equal ["root", "nested"], parse_property_path("root.nested")
    assert_equal ["root", "nested"], parse_property_path('root["nested"]')
    assert_equal ["root", "double", "nested"], parse_property_path("root.double.nested")
    assert_equal ["root", "double", "nested"], parse_property_path('root["double"].nested')
    assert_equal ["root", "double", "nested"], parse_property_path('root["double"]["nested"]')
    assert_equal ["root", "array", 0], parse_property_path("root.array[0]")
    assert_equal ["root", "array", 1], parse_property_path("root.array[1]")
    assert_equal ["root", "array", -1], parse_property_path("root.array[-1]")
    assert_equal ["root", "array", 0, "nested"], parse_property_path("root.array[0].nested")
    assert_equal ["root", "array2", 0, 1, "nested"], parse_property_path("root.array2[0][1].nested")
    assert_equal ["root", "nested", "array", 0, "double", 1], parse_property_path("root.nested.array[0].double[1]")
    assert_equal ["root", 'key with "escaped" quotes'], parse_property_path('root["key with \"escaped\" quotes"]')
    assert_equal ["root", "key with a ."], parse_property_path('root["key with a ."]')
    assert_equal ['root key with "escaped" quotes', "nested"], parse_property_path('["root key with \"escaped\" quotes"].nested')
    assert_equal ["root key with a .", 1], parse_property_path('["root key with a ."][1]')
    assert_equal ["root", "*", "field", 1], parse_property_path("root[*].field[1]")
    assert_equal ["root", "*", "field", 1], parse_property_path('root["*"].field[1]')
  end

  def test_should_raise_error_if_given_an_invalid_path
    ["root[", 'root["nested]', "root.array[abc]", "root.", "root.array.[1]"].each do |bad_path|
      assert_raises(PropertyAccess::InvalidPropertyPath) do
        parse_property_path(bad_path)
      end
    end
  end
end
