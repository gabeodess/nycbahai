class ImportContributionsJob < ActiveJob::Base
  queue_as :default

  def perform(file)
    sheet = Roo::Spreadsheet.open(file)
    if sheet.cell(4,4) == 'Date'
      sheet.each({:name => "Name", :amount => 'Amount', :fund => 'Class', :date => "Date", :num => "Num"}) do |hash|
        puts hash
        next unless hash[:amount].to_f > 0 && hash[:name].present?
        hash[:date] = Date.strptime(hash[:date], "%m/%d/%Y") if hash[:date].is_a?(String)
        Contribution.create!(hash) if hash[:num].blank? || !Contribution.where(:num => hash[:num]).exists?
      end
    end
  end

end
