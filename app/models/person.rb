class Person < ActiveRecord::Base
  
  BOROUGHS = %w( manhattan brooklyn staten\ island queens the\ bronx )
  
  # ==============
  # = Attributes =
  # ==============
  store_accessor :address, :street1, :street2, :borough, :neighborhood, :zip
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :first_name
  
  # ===========
  # = Ransack =
  # ===========
  # ransacker :borough, :formatter => proc{ |v|
  #   Person.where(%Q{people.address @> '{"borough":"manhattan"}'}).select(:id)
  # } do |parent|
  #   parent.table[:id]
  # end
  
  ransacker :borough, :formatter => proc{ |v| v } do
    Arel.sql("(people.address -> 'borough')")
  end

  ransacker :neighborhood, :formatter => proc{ |v| v } do
    Arel.sql("(people.address -> 'neighborhood')")
  end

  # ransacker :borough do |parent|
  #   Arel::Nodes::InfixOperation.new('->', parent.table[:address], Arel::Nodes.build_quoted('borough'))
  # end
    
  # ====================
  # = Instance Methods =
  # ====================
  def declared?
    declared_on.present?
  end
  
  def name
    [first_name, last_name].join(' ')
  end
  
end
