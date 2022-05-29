class Order
  attr_reader :dishes, :customer_name

  def initialize(customer_name, dishes)
    # items is an array of dishes
    @customer_name = customer_name
    @dishes = dishes
  end

  def add(dish)
    @dishes << dish
  end

  def remove(dish)
    # dish_name is present in the order
    @dishes.delete_at(@dishes.find_index(dish))
  end

  def produce_receipt
    # itemised including grand total
      # produces itemised receipt
    # Returns string in following format: "Meal 1 £Price 1 + Meal 2 £Price 2 ... = Total £GrandTotal"
    # Start with empty string
    # For each dish in order
    # Add to string the name + £ then formatted price
    # Keep a total of price meantime
    # Then add price
    receipt_string = ""
    total = 0.0
    count = 0
    # TODO finish this method
    while count < @dishes.length
      receipt_string.concat(@dishes[count].name)
      receipt_string.concat(" £")
      receipt_string.concat(sprintf("%.2f", @dishes[count].price))
      total += @dishes[count].price
      receipt_string.concat(" + ") unless count == @dishes.length-1
      count += 1
    end
    receipt_string.concat(" = Total £")
    receipt_string.concat(sprintf("%.2f", total))
    return receipt_string
  end
end
