# Preview all emails at http://localhost:3000/rails/mailers/mailer
class MailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mailer/summary_email
  def summary_email
    @contribution = Contribution.find_emailable.first
    Mailer.summary_email(@contribution.name, @contribution.date.year)
  end

end
