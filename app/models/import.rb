# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Import < ActiveRecord::Base
  
  # ===========
  # = Setters =
  # ===========
  def file=(val)
    ImportPeopleJob.perform_now(val.tempfile)
  end
  
end
