ActiveAdmin.register SummaryEmail do

  action_item :send_summaries do
    link_to "Send Summaries for #{SummaryEmail.default_year}", :send_summaries_admin_contributions, :method => :post, :data => {:disable_with => '...'}
  end

  permit_params :contributer, :year

  form do |f|
    f.object.year ||= Time.zone.today.year - 1
    f.inputs do
      f.input :contributer, collection: Contribution.reorder(:name).pluck("DISTINCT name")
      f.input :year
    end
    f.actions
  end

end
