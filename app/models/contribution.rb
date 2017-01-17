# == Schema Information
#
# Table name: contributions
#
#  id         :integer          not null, primary key
#  amount     :money            not null
#  date       :date
#  num        :integer
#  name       :string
#  fund       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contribution < ActiveRecord::Base

  # ==========
  # = Scopes =
  # ==========
  scope :find_by_year, (lambda do |year|
    start = Date.parse("01-01-#{year}")
    where({:date => start..start.end_of_year})
  end)
  scope :find_emailable, ->{ joins(:contributer_email_address) }

  # ================
  # = Associations =
  # ================
  belongs_to :contributer_email_address, :foreign_key => :name, :primary_key => :name
  has_many :summary_emails, :foreign_key => :contributer, :primary_key => :name

  # ====================
  # = Instance Methods =
  # ====================
  delegate :email, :to => :contributer_email_address, :allow_nil => true

  def create_summary_email!
    summary_emails.create!({:year => date.year}) unless summary_emails.where(:year => date.year).exists?
  end

end
