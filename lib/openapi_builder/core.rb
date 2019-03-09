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

    def initialize(path_to_spec)
      @dirname = File.dirname(path_to_spec)
      @data = load_file(path_to_spec)
      load_paths
      load_components
    end

    def load_components
      @data["components"] = Hash.new.tap do |components|
        Dir["#{@dirname}/components/*"].each do |component_path|
          basename = File.basename(component_path)
          next if basename.include? "."
          components[File.basename(component_path)] = Hash.new.tap do |block|
            Dir["#{component_path}/*"].each do |file|
              content = load_file(file)
              next unless content
              block[File.basename(file, '.*')] = content
            end
          end
        end
      end
    end

    def load_paths
      @data["paths"] = Hash.new.tap do |paths|
        Dir["#{@dirname}/paths/*"].each do |file|
          content = load_file(file)
          next unless content
          key = File.basename(file, '.*').gsub('@', '/')
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
  end
end
