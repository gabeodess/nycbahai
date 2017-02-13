# == Schema Information
#
# Table name: contributer_email_addresses
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  key        :string           not null
#
# Indexes
#
#  index_contributer_email_addresses_on_email  (email)
#  index_contributer_email_addresses_on_key    (key) UNIQUE
#  index_contributer_email_addresses_on_name   (name) UNIQUE
#

class ContributerEmailAddress < ActiveRecord::Base

  # ================
  # = Associations =
  # ================
  has_many :contributions, :foreign_key => :name, :primary_key => :name

  # ===============
  # = Validations =
  # ===============
  validates :name, :email, :presence => true
  validates :name, :uniqueness => true

  # ===========
  # = Setters =
  # ===========
  def name=(val)
    self[:name] = val
    self[:key] = val.parameterize
  end

end
