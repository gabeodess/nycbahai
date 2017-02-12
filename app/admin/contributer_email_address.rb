ActiveAdmin.register ContributerEmailAddress do

  collection_action :import, :method => :post do
    ImportEmailsJob.perform_later(Roo::Spreadsheet.open(params[:import][:file]).to_csv)
    redirect_to :importing_admin_contributions
  end

  sidebar :import do
    form_for :import, :url => import_admin_contributer_email_addresses_path, :html => {:multipart => true} do |f|
      f.file_field :file, class: 'form-group'
      f.submit
    end
  end

  permit_params :name, :email

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :name, :collection => Contribution.includes(:contributer_email_address).where(:contributer_email_addresses => {:id => nil}).uniq.pluck(:name).sort
      f.input :email
    end
    f.actions
  end

end
