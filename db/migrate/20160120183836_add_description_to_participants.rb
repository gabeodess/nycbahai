class AddDescriptionToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :description, :string
  end
end
