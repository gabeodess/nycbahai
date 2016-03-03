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

  # ====================
  # = Instance Methods =
  # ====================
  delegate :email, :to => :contributer_email_address, :allow_nil => true

end
