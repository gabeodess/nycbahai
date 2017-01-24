ActiveAdmin.register Import do

  permit_params :file

  menu false

  controller do
    def create
      create! do |format|
        format.html{ redirect_to :admin_people }
      end
    end
  end

end
