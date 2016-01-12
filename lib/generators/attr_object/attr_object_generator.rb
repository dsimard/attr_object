class AttrObjectGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_attr_object_file
    template "attr_object.rb", "app/attr_objects/#{lower_class_name}_attr.rb"
  end

  protected
  def class_name
    file_name.classify
  end

  def lower_class_name
    class_name.underscore
  end

  def class_delegate
    del = self.args.first
    del.classify if del
  end
end
