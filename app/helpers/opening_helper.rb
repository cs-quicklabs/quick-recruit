module OpeningHelper
  def priority_color(status)
    case status
    when "p3"
      "yellow"
    when "p2"
      "orange"
    when "p1"
      "fuchsia"
    when "u"
      "red"
    end
  end
end
