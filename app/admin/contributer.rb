ActiveAdmin.register_page "Contributers" do

  page_action :no_email_breakdown do
    @date_start = 1.year.ago.beginning_of_year
    @date_end = @date_start.end_of_year
    @contributions = Contribution.includes(:contributer_email_address).where(:date => @date_start..@date_end, :contributer_email_addresses => {:id => nil})
  end

  action_item :no_email_breakdown do
    link_to("Print Breakdowns", :admin_contributers_no_email_breakdown)
  end

  content do
    table_for Contribution.includes(:contributer_email_address).select("DISTINCT ON(contributions.name) name, key") do
      column(:name)
      column(:email)
    end
  end
end
