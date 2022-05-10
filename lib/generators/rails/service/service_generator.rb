class Rails::ServiceGenerator < Rails::Generators::NamedBase
  def create_files
    create_service_file
    create_test_file
  end

  private

  def plural_model_name
    plural_name.capitalize
  end

  def singular_model_name
    plural_name.singularize
  end

  def model_name
    singular_name.capitalize
  end

  def create_service_file
    create_file "app/services/#{plural_name}_service.rb", <<-FILE
class #{plural_model_name}Service
  def #{plural_name}
    #{model_name}.all
  end

  def #{singular_model_name}(id)
    #{model_name}.find_by(id: id)
  end

  def create(params)
    #{singular_model_name} = #{model_name}.new(params)
    #{singular_model_name}.save
  end

  def update(id, params)
    #{singular_model_name} = #{model_name}.find_by(id: id)
    #{singular_model_name}.update(params)
  end

  def delete(id)
    #{model_name}.destroy(id)
  end
end
    FILE
  end

  def create_test_file
    create_file "test/services/#{plural_name}_service_test.rb", <<-FILE
require 'test_helper'

class #{plural_model_name}ServiceTest < ActiveSupport::TestCase
  # test 'the truth' do
  #   assert true
  # end
end
    FILE
  end
end
