{
  :count => Sidekiq::Queue.new("import").size
}.to_json
