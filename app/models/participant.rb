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
