ActiveAdmin.register Activity do

  show do
    attributes_table do
      %w( id type address contact borough neighborhood created_at updated_at ).each do |item|
        row(item)
      end
    end
    h2{"Hosts"}
    table_for resource.hosts do
      column(:person)
    end
    h2{"Participants"}
    table_for resource.participants do
      column(:person)
      column(:description)
      column(:bahai)
    end
    active_admin_comments
  end

  permit_params :street1, :street2, :city, :state, :zip, :name, :phone, :email, :type, :borough, :neighborhood, :last_update_on, :hosts_attributes => [:person_id, :id, :_destroy], :participants_attributes => [:person_id, :bahai, :id, :_destroy, :description]
  form do |f|
    @people = Person.order('first_name ASC')
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :type
      f.input :last_update_on, :as => :datepicker
      f.input :borough
      f.input :neighborhood
      hr
      f.input :street1
      f.input :street2
      f.input :city
      f.input :state
      f.input :zip
      hr
      f.input :name
      f.input :phone
      f.input :email
    end
    f.has_many :hosts do |f2|
      f2.input :person, :collection => @people
    end
    hr
    f.has_many :participants, :allow_destroy => true do |f2|
      f2.input :person, :collection => @people
      f2.input :description
      f2.input :bahai
    end
    f.actions
  end

end
