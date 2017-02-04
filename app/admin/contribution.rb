ActiveAdmin.register Contribution do

  config.sort_order = 'date_desc'

  member_action :change_name, method: :put do
    @name = params.dig(:change_name, :name)
    Contribution.where(name: resource.name).update_all(name: @name)
    redirect_to admin_contributions_path(q: {name_eq: @name})
  end

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
    redirect_to :importing_admin_contributions
  end

  collection_action :send_summaries, :method => :post do
    SummaryEmailsJob.perform_later
    redirect_to :admin_summary_emails, :notice => "Summary emails are being sent."
  end

  collection_action :importing

  collection_action :import_job_count

  member_action :preview

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

  sidebar :change_name, only: [:show] do
    form_for :change_name, method: :put, :url => change_name_admin_contribution_path(resource) do |f|
      f.text_field :name, style: 'margin-bottom: 10px'
      f.submit 'Change Name', data: {disable_with: '...'}
    end
  end

  permit_params :name, :date, :amount, :fund
  form do |f|
    f.inputs do
      f.input :name
      f.input :amount
      f.input :date
      f.input :fund
    end
    f.actions
  end

  filter :amount, :as => :numeric
  preserve_default_filters!
  index do
    selectable_column
    id_column
    column(:amount){ |i| number_to_currency(i.amount) }
    column(:date)
    column(:num)
    column(:name){ |i| link_to(i.name, contributer_admin_contribution_path(i.name)) if i.name }
    column(:fund)
    column(:email)
    column(:created_at)
    column(:updated_at)
    actions do |resource|
      link_to 'Preview', [:preview, :admin, resource]
    end
  end

end
