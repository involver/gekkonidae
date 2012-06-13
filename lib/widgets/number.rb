require 'json'

class Number
  def initialize(item1, item2 = nil)
    @item1, @item2 = item1, item2
  end

  def to_json(*a)
    {"item" => @item2 ? [@item1, @item2] : [@item1]}.to_json
  end
end

class NumberItem
  def initialize(value, text = '')
    @value, @text = value, text
  end

  def to_json(*a)
    {"text" => @text, "value" => @value}.to_json
  end
end