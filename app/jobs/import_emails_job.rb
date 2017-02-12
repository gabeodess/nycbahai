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
    email = ContributerEmailAddress.ransack(name_matches: @item[:name]).result.first_or_initialize
    email.update!(@item)
    Contribution.ransack(name_matches: email.name).result.update_all(name: email.name) if email.name.present?
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
