# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  type           :string           not null
#  last_update_on :date             not null
#  address        :jsonb            not null
#  contact        :jsonb            not null
#  borough        :string
#  neighborhood   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Activity < ActiveRecord::Base

  self.inheritance_column = :_type

  store_accessor :address, :street1, :street2, :city, :state, :zip
  store_accessor :contact, :name, :phone, :email

  # ================
  # = Associations =
  # ================
  has_many :hosts
  has_many :participants

  accepts_nested_attributes_for :hosts, :allow_destroy => true, :reject_if => proc { |obj| obj['person_id'].blank? }
  accepts_nested_attributes_for :participants, :allow_destroy => true, :reject_if => proc { |obj| [obj['person_id'], obj['description']].all?(&:blank?) }

  # ===============
  # = Validations =
  # ===============
  validates :last_update_on, :presence => true

end
