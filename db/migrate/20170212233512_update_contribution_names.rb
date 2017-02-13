class UpdateContributionNames < ActiveRecord::Migration[5.0]
  def change

    Contribution.ransack(name_matches: '%,%').result.each do |contribution|
      contribution.update_attribute(:name, contribution.name)
    end

  end
end
