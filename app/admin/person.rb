ActiveAdmin.register Person do

  sidebar "New Import" do
    form_for [:admin, Import.new], :html => {:multipart => true} do |f|
      f.file_field :file
      f.submit
    end
  end

  # =========
  # = Index =
  # =========
  filter :first_name
  filter :last_name
  filter :email
  filter :phone
  filter :declared_on
  # filter :borough_eq, :collection => Person::BOROUGHS, :as => :string
  filter :borough_has_key, collection: proc{Person.pluck("DISTINCT people.address -> 'borough'").sort}, :as => :select
  filter :neighborhood_has_key, collection: proc{Person.pluck("DISTINCT people.address -> 'neighborhood'").sort}, :as => :select

  index do
    selectable_column
    id_column
    column(:image){ |person| gravatar_image_tag(person.email) }
    column(:name, :sortable => :first_name)
    column(:borough)
    column(:neighborhood)
    actions
  end

  # ========
  # = Form =
  # ========
  permit_params *%w( first_name last_name email phone borough neighborhood zip street1 street2 declared_on )

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :declared_on, :as => :datepicker
    end
    f.inputs do
      f.input :street1
      f.input :street2
      f.input :borough, :collection => Person::BOROUGHS
      f.input :neighborhood
      f.input :zip
    end
    f.actions
  end

end
