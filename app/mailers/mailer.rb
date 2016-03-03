class Mailer < ApplicationMailer

  def summary_email(name, year, email = nil)
    @name = name
    @contributer_email_address = ContributerEmailAddress.where(:name => @name).first
    @email = email || @contributer_email_address.try(:email)
    @first_name = @name.split(',').last.strip
    @last_name = @name.split(',').first.strip
    @year = year
    @contributions = Contribution.where(:name => @name).find_by_year(@year)

    mail to: @email, :from => %("#{ENV['TREASURER_NAME']}" <#{ENV['TREASURER_EMAIL']}>), :subject => "NYC Baha'i Contribution Summary"
  end

end
