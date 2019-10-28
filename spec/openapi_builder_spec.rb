RSpec.describe OpenapiBuilder do
  let(:path_to_spec) { "./spec/data/src/openapi.yml" }
  let(:expected_result) { YAML.load_file("./spec/data/expected_openapi.yml") }

  it "builds result hash" do
    result = OpenapiBuilder.call(path_to_spec).data

    expect(result).to eq(expected_result)
  end

  context "with filter" do
    let(:expected_result) { YAML.load_file("./spec/data/filtered_openapi.yml") }

    it "builds hash with specific paths" do
      result = OpenapiBuilder.call(path_to_spec, paths: ['pets/{id}']).data

      expect(result).to eq(expected_result)
    end
  end
end
