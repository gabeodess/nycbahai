class ImportEmailsJob < ApplicationJob

  queue_as :import

  def perform(item)
    @item = item
    case @item
    when String
      perform_group
    else
      perform_individual
    end
  end

  def perform_individual
    email = @item[:email].strip
    helper = Contribution.new(name: @item[:name])
    cea = ContributerEmailAddress.where(key: helper.key).first_or_initialize
    cea.update!({
      email: email,
      name: helper.name,
      key: helper.key
    })
  end

  def perform_group
    Roo::Spreadsheet.open(file.path, extension: :csv).each(name:'Name', email: 'Email') do |hash|
      ImportEmailsJob.perform_later(hash.each { |k, v| hash[k] = v.strip } ) if hash[:email].to_s.strip.email?
    end
  end

  def file
    @file ||= Tempfile.new('csv').tap{ |i| i.write(@item); i.close }
  end

end
