Ransack.configure do |config|
  config.add_predicate 'has_key', {
    arel_predicate: 'has_key',
    validator: proc { |v| v.present? }
  }
end
