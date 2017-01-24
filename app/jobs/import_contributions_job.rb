class ImportContributionsJob < ActiveJob::Base
  queue_as :import

  def perform(item)
    case item
    when Hash
      process(item)
    when File, ActionDispatch::Http::UploadedFile
      process_file(item)
    end
  end

  def process_file(file)
    @sheet = Roo::Spreadsheet.open(file)
    if @sheet.cell(4,4) == 'Date'
      parse1
    else
      parse2
    end
  end

  def process(hash)
    hash[:name] = hash[:name].presence || 'Anonymous'
    Contribution.where(:num => hash[:num]).first_or_create!(hash)
  end

  def parse2
    @sheet.each do |hash|
      ImportContributionsJob.perform_later({
        :num => hash[3],
        :name => hash[4],
        :amount => hash[8],
        :fund => nil,
        :date => Date.strptime(hash[1], '%m/%d/%Y').to_s(:db)
      }) if hash[1].to_s.match(/^[\d\/]+$/)
    end
  end

  def parse1
    @sheet.each({:name => "Name", :amount => 'Amount', :fund => 'Class', :date => "Date", :num => "Num"}) do |hash|
      puts hash
      next unless hash[:amount].to_f > 0 && hash[:name].present?
      hash[:amount].to_s.gsub!(/[^\d\.]/, '')
      hash[:date] = Date.strptime(hash[:date], "%m/%d/%Y") if hash[:date].is_a?(String)
      hash[:date] = hash[:date].to_s(:db)
      ImportContributionsJob.perform_later(hash)
    end
  end

end
