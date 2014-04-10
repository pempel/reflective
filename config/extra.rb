def parse(name)
  erb("#{File.dirname(__FILE__)}/templates/#{name}")
end
