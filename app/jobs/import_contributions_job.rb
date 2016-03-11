class ImportContributionsJob < ActiveJob::Base
  queue_as :default

  def perform(file)
    sheet = Roo::Spreadsheet.open(file)
    if sheet.cell(4,4) == 'Date'
      sheet.each({:name => "Name", :amount => 'Amount', :fund => 'Class', :date => "Date", :num => "Num"}) do |hash|
        puts hash
        next unless hash[:amount].to_f > 0 && hash[:name].present?
        hash[:amount].gsub!(/[^\d\.]/, '')
        hash[:date] = Date.strptime(hash[:date], "%m/%d/%Y") if hash[:date].is_a?(String)
        @contribution = (hash[:num].present? && Contribution.find_by({:num => hash[:num]})) || Contribution.new(hash)
        @contribution.update!(hash)
      end
    end
  end

end
