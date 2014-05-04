def parse_template(name)
  path = File.join(File.dirname(__FILE__), name)
  special_name = "#{path}.#{env}.erb"
  general_name = "#{path}.erb"
  erb(File.exists?(special_name) ? special_name : general_name)
end
