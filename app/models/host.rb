# == Schema Information
#
# Table name: hosts
#
#  id          :integer          not null, primary key
#  activity_id :integer          not null
#  person_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_hosts_on_activity_id  (activity_id)
#  index_hosts_on_person_id    (person_id)
#
# Foreign Keys
#
#  fk_rails_08990ed815  (person_id => people.id)
#  fk_rails_852f7da4ca  (activity_id => activities.id)
#

class Host < ActiveRecord::Base

  # ================
  # = Associations =
  # ================
  belongs_to :activity
  belongs_to :person

  # ===============
  # = Validations =
  # ===============
  validates :person, :uniqueness => {:scope => [:activity_id]}

end
