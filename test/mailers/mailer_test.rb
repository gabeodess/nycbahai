require 'test_helper'

class MailerTest < ActionMailer::TestCase
  test "summary_email" do
    @contribution = FactoryGirl.create(:contribution, :include_email => true)
    mail = Mailer.summary_email(@contribution.name, @contribution.date.year)
    assert_equal [@contribution.email], mail.to
    assert_equal [ENV['TREASURER_EMAIL']], mail.from
  end

end
