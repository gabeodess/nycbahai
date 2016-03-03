class ImportPeopleJob < ActiveJob::Base
  queue_as :default

  def perform(file)
    sheet = Roo::Spreadsheet.open(file)
    if sheet.cell(1,1) == 'Given Name'
      sheet.each({:first_name => "Given Name", :gender => "Sex", :borough => "Borough", :neighborhood => "Neighborhood"}) do |hash|
        next if hash[:first_name].blank?
        Person.find_or_create_by(:first_name => hash[:first_name]) do |person|
          person.assign_attributes(hash.reject{ |k,v| v.blank? })
        end
      end
    end
  end

end
