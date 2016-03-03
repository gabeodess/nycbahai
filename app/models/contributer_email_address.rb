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

end
