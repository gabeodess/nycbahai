require 'test_helper'

class SummaryEmailsJobTest < ActiveJob::TestCase

  test "sending emails" do
    @c1 = FactoryGirl.create(:contribution)
    @c2 = FactoryGirl.create(:contribution)
    @c3 = FactoryGirl.create(:contribution)
    @c4 = FactoryGirl.create(:contribution)
    [@c1, @c2].each do |contribution|
      FactoryGirl.create(:contributer_email_address, :name => contribution.name)
    end
    FactoryGirl.create(:summary_email, :contributer => @c3.name)

    # Should skip items that do not have an email address or have already received an email summary
    assert_difference "Mailer.deliveries.length", 2 do
      assert_difference "SummaryEmail.count", 2 do
        perform_enqueued_jobs do
          SummaryEmailsJob.perform_now
        end
      end
    end
  end

end
