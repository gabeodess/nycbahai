ActiveAdmin.register Contribution do

  batch_action :resend do |ids|
    Contribution.where(:id => ids).select("DISTINCT ON(contributions.name) contributions.name, contributions.date").find_emailable.each do |contribution|
      if summary_email = contribution.summary_emails.where(:year => contribution.date.year).first
        summary_email.resend!
      else
        contribution.create_summary_email!
      end
    end
    redirect_to :admin_summary_emails
  end

  collection_action :import, :method => :post do
    ImportContributionsJob.perform_now(params[:import][:file])
    redirect_to :admin_contributions
  end

  collection_action :send_summaries, :method => :post do
    SummaryEmailsJob.perform_later
    redirect_to :admin_summary_emails, :notice => "Summary emails are being sent."
  end

  member_action :contributer do
    @contributions = Contribution.where(:name => params[:id])
  end

  action_item :send_summaries do
    link_to "Send Summaries for #{SummaryEmail.default_year}", :send_summaries_admin_contributions, :method => :post, :data => {:disable_with => '...'}
  end

  sidebar :import do
    form_for :import, :url => import_admin_contributions_path, :html => {:multipart => true} do |f|
      f.file_field :file
      f.submit
    end
  end

  filter :amount, :as => :numeric
  preserve_default_filters!

  index do
    selectable_column
    id_column
    column(:amount){ |i| number_to_currency(i.amount) }
    column(:date)
    column(:num)
    column(:name){ |i| link_to(i.name, contributer_admin_contribution_path(i.name)) }
    column(:fund)
    column(:email)
    column(:created_at)
    column(:updated_at)
    actions
  end

end
