class Text
  def initialize(items)
    @items = items
  end

  def to_json(*a)
    {"item" => @items}.to_json
  end
end

class TextItem
  def initialize(text, type = 0)
    @text, @type = text, type
  end

  def to_json(*a)
    {"text" => @text, "type" => @type}.to_json
  end
end