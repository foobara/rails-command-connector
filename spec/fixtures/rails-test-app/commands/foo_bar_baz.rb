class FooBarBaz < Foobara::Command
  result foo: :string, bar: :string, baz: :string

  def execute
    { foo: "foo value", bar: "bar value", baz: "baz value" }
  end
end
