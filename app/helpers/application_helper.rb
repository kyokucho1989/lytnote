module ApplicationHelper
  def status_color(status)
    if status == "完了"
      "bg-success"
    elsif status == "中止"
      "bg-dark text-white"
    else
      "d-none"
    end
  end
end
