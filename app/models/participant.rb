# == Schema Information
#
# Table name: participants
#
#  id          :integer          not null, primary key
#  activity_id :integer          not null
#  person_id   :integer
#  bahai       :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#
# Indexes
#
#  index_participants_on_activity_id  (activity_id)
#  index_participants_on_person_id    (person_id)
#
# Foreign Keys
#
#  fk_rails_673abba6bd  (person_id => people.id)
#  fk_rails_f1ac06fbea  (activity_id => activities.id)
#

class Participant < ActiveRecord::Base

  # ================
  # = Associations =
  # ================
  belongs_to :activity
  belongs_to :person

  # ===============
  # = Validations =
  # ===============
  validates :person, :uniqueness => {:scope => [:activity_id], :allow_blank => true}

end
