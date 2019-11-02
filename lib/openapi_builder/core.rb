require "json"
require "yaml"

module OpenapiBuilder
  class Core
    attr_reader :data

    def to_yaml
      @data.to_yaml
    end

    def to_json
      @data.to_json
    end

    private

    def initialize(path_to_spec, paths: [], clear: false)
      @dirname = File.dirname(path_to_spec)
      @data = load_file(path_to_spec)
      @paths = paths
      @clear = clear
      load_paths
      load_components
    end

    def load_components
      @data["components"] = {}.tap do |components|
        component_dirs.each do |component_path|
          components[File.basename(component_path)] = load_component(component_path)
        end
      end
    end

    def component_dirs
      Dir["#{@dirname}/components/*"].select { |component_path| File.directory? component_path }
    end

    def load_component(component_path)
      {}.tap do |block|
        Dir["#{component_path}/*"].each do |file|
          content = load_file(file)
          next unless content

          block[File.basename(file, ".*")] = content
        end
      end
    end

    def load_paths
      @data["paths"] = {}.tap do |paths|
        Dir["#{@dirname}/paths/*"].each do |file|
          content = load_file(file)
          next unless content

          key = File.basename(file, ".*").tr("@", "/")
          next if filter_paths? && !key.start_with?(*@paths)

          paths["/#{key}"] = content
        end
      end
    end

    def load_file(path)
      case File.extname(path)
      when ".yml", ".yaml"
        YAML.load_file(path)
      when ".json"
        JSON.parse(File.read(path))
      end
    end

    def filter_paths?
      @paths.any?
    end
  end
end
