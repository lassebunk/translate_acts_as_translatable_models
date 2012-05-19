class Railtie < Rails::Railtie
  rake_tasks do
    load File.join(File.dirname(__FILE__), "tasks", "acts_as_translatable_task.rake")
  end
end