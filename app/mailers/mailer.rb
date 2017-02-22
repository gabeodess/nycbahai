class Mailer < ApplicationMailer

  def summary_email(name, year, email = nil)
    @name = name
    @year = year
    @contributions = Contribution.where(:name => @name).year(@year)
    @email = @contributions.map(&:email).compact.first
    names = @name.include?(',') ? @name.split(',').reverse : @name.split(' ')
    @first_name = names.first.strip
    @last_name = names.last.strip if names.length > 1

    mail to: @email, :from => %("#{ENV['TREASURER_NAME']}" <#{ENV['TREASURER_EMAIL']}>), :subject => "NYC Baha'i Contribution Summary"
  end

end
