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
  scope :find_emailable, ->{ joins(:contributer_email_address) }
  scope :year, ->(year){
    start = Date.parse("01-01-#{year}")
    where({:date => start..start.end_of_year})
  }

  # ================
  # = Associations =
  # ================
  belongs_to :contributer_email_address, :foreign_key => :name, :primary_key => :name
  has_many :summary_emails, :foreign_key => :contributer, :primary_key => :name

  # =====================
  # = Nested Attributes =
  # =====================
  accepts_nested_attributes_for :contributer_email_address, :allow_destroy => true, :reject_if => proc { |obj| obj['email'].blank? }

  # ===========
  # = Setters =
  # ===========
  def name=(val)
    self[:name] = val.include?(',') ? val.split(',').reverse.map(&:strip).join(' ') : val.strip
  end

  def amount=(val)
    self[:amount] = val.to_d
  end

  # ====================
  # = Instance Methods =
  # ====================
  delegate :email, :to => :contributer_email_address, :allow_nil => true

  def create_summary_email!
    summary_emails.create!({:year => date.year}) unless summary_emails.where(:year => date.year).exists?
  end

end
