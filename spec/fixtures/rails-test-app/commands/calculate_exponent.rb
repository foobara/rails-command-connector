class CalculateExponent < Foobara::Command
  inputs type: :attributes,
         element_type_declarations: {
           base: :integer,
           exponent: :integer
         },
         required: %i[base exponent]

  result :integer

  def execute
    base**exponent
  end
end
