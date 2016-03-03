class Import < ActiveRecord::Base
  
  # ===========
  # = Setters =
  # ===========
  def file=(val)
    ImportPeopleJob.perform_now(val.tempfile)
  end
  
end
