# module Arel
#
#   def self.add_predicate(predicate, operator)
#
#     $method_name = predicate
#     $operator = operator
#     $class_name = $method_name.to_s.camelcase
#
#     module Arel::Predications
#       define_method($method_name) do |right|
#         :"Arel::Nodes::#{$class_name}".to_s.constantize.new(self, quoted_node(right))
#       end
#     end
#
#     node = Class.new(Arel::Nodes::Binary) do
#       def operator; $operator end
#     end
#     Arel::Nodes.const_set($class_name, node)
#
#     class Arel::Visitors::PostgreSQL
#       private
#       define_method(:"visit_Arel_Nodes_#{$class_name}") do |o, collector|
#         infix_value o, collector, " #{$operator} "
#       end
#     end
#
#   end
#
# end

$method_name = :has_key
$operator = :"?"
$class_name = $method_name.to_s.camelcase

module Arel::Predications
  define_method($method_name) do |right|
    :"Arel::Nodes::#{$class_name}".to_s.constantize.new(self, quoted_node(right))
  end
end

node = Class.new(Arel::Nodes::Binary) do
  def operator; $operator end
end
Arel::Nodes.const_set($class_name, node)

class Arel::Visitors::PostgreSQL
  private
  define_method(:"visit_Arel_Nodes_#{$class_name}") do |o, collector|
    infix_value o, collector, " #{$operator} "
  end
end
