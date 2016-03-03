ENV['REDIS_ENDPOINT'] ||= ENV["REDISCLOUD_URL"]

Sidekiq.default_worker_options = { "backtrace" => true }

redis = {
  :url => ENV["REDIS_ENDPOINT"],
  :namespace => ENV["SIDEKIQ_NAMESPACE"] || "nycbahai_#{Rails.env}"
}

Sidekiq.configure_server do |config|
  config.redis = redis
end

Sidekiq.configure_client do |config|
  config.redis = redis
end
