require "openapi_builder/core"
require "openapi_builder/version"

module OpenapiBuilder
  def self.call(*attrs)
    Core.new(*attrs)
  end
end
