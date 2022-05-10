class Rails::ServiceGenerator < Rails::Generators::NamedBase
  def create_service_file
    create_file "app/services/#{plural_name}_service.rb", <<-FILE
class #{plural_name.capitalize}Service
  def #{plural_name}
    #{plural_name.singularize.capitalize}.all
  end

  def #{plural_name.singularize}(id)
    #{plural_name.singularize.capitalize}.find_by(id: id)
  end

  def create(params)
    #{plural_name.singularize} = #{plural_name.singularize.capitalize}.new(params)
    #{plural_name.singularize}.save
  end

  def update(id, params)
    #{plural_name.singularize} = #{plural_name.singularize.capitalize}.find_by(id: id)
    #{plural_name.singularize}.update(params)
  end

  def delete(id)
    #{plural_name.singularize.capitalize}.destroy(id)
  end
end
    FILE
  end
end
