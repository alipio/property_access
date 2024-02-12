# frozen_string_literal: true

require_relative "property_access/version"
require_relative "property_access/property_path"

class PropertyAccess
  class Error < StandardError; end

  InvalidPropertyPath = Class.new(Error)
end
