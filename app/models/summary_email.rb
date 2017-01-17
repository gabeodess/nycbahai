# == Schema Information
#
# Table name: summary_emails
#
#  id          :integer          not null, primary key
#  contributer :string
#  year        :integer
#  sent_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_summary_emails_on_contributer           (contributer)
#  index_summary_emails_on_contributer_and_year  (contributer,year) UNIQUE
#

class SummaryEmail < ActiveRecord::Base

  # ===============
  # = Validations =
  # ===============
  validates :contributer, :year, :presence => true
  validates :contributer, :uniqueness => {:scope => [:year]}

  # =========
  # = Hooks =
  # =========
  after_create do
    send_email
  end

  def send_email
    Mailer.summary_email(contributer, year).deliver_later
  end
  alias_method :resend!, :send_email

  # =================
  # = Class Methods =
  # =================
  def self.default_year
    Time.zone.today.year - 1
  end

end
