class Menu

  attr_reader :venue_name, :dishes

  def initialize(venue_name)
    @venue_name = venue_name
    @dishes = []    
  end

  def add(dish)
    # dish names uniquely identify them
    # adding a dish with a name that is already
    # in the menu over-writes the previous entry
    if named_in_menu?(dish) 
      # remove old record of dish to replace with this new one
      remove!(dish.name)
    end
    @dishes << dish
  end

  def remove!(dish_name)
    # dish_name is a string to match an existing dish's name
    # remove first instance it finds
    @dishes.each do |dish|
      if dish.name == dish_name
        @dishes.delete(dish)
        return
      end
    end
  end

  def dish_names
    # returns array of dish names already in menu
    names = []
    @dishes.each do |dish|
      names << dish.name
    end
    return names
  end

  def show
    # returns an array of formatted strings as such
    # [ "Take-away name", "1. First dish name: First dish description, £price" ...etc...]
    menu_strings = []
    menu_strings << @venue_name
    count = 1
    while count <= @dishes.length
      # Add a menu number
      dish_string = ""
      dish_string.concat(count.to_s)
      dish_string.concat(". ")
      dish_string.concat(@dishes[count-1].name)
      dish_string.concat(": ")
      dish_string.concat(@dishes[count-1].description)      
      dish_string.concat(", £")
      price_string = sprintf("%.2f", @dishes[count-1].price)
      dish_string.concat(price_string)
      menu_strings << dish_string
      count += 1
    end
    return menu_strings
  end

  def named_in_menu?(dish)
    # returns boolean based on if dish already in menu
    return (@dishes.find {|d| d.name == dish.name} != nil)
  end

end
