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
    Mailer.summary_email(contributer, year).deliver_later
  end

  # =================
  # = Class Methods =
  # =================
  def self.default_year
    Time.zone.today.year - 1
  end

end
