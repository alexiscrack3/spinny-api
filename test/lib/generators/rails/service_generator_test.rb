# frozen_string_literal: true

require "test_helper"
require "generators/rails/service/service_generator"

module Rails
  class ServiceGeneratorTest < Rails::Generators::TestCase
    tests Rails::ServiceGenerator
    destination Rails.root.join("tmp/generators")
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
