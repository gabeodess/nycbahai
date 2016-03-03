class SummaryEmailsJob < ActiveJob::Base
  queue_as :default

  def perform
    @year = Time.zone.today.year - 1
    Contribution.joins(:contributer_email_address).find_by_year(@year).uniq.pluck(:name).each do |name|
      SummaryEmail.create(:contributer => name, :year => @year)
    end
  end
end
