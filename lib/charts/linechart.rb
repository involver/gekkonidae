class Linechart
  attr_accessor :axisx, :axisy, :colour

  def initialize(items)
    @items = items
  end

  def to_json(*a)
    {
      "item" => @items,
      "settings" => {
        "axisx" => @axisx || [],
        "axisy" => @axisy || [],
        "colour" => @colour || "ff9900"
      }
    }.to_json
  end
end