require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('config/schedule.yml', Rails.root))
    SidekiqScheduler::Scheduler.new.schedule!
  end
end