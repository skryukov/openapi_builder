require "openapi_builder/core"
require "openapi_builder/version"

module OpenapiBuilder
  def self.call(*args, **options)
    Core.new(*args, **options)
  end
end
