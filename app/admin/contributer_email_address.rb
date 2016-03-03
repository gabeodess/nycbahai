ActiveAdmin.register ContributerEmailAddress do

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
