class Dish

  attr_reader :name, :description, :price
  def initialize(name, description, price)
    # name should be unique
    # price is a float
    @name = name
    @description = description
    @price = price
  end

end
