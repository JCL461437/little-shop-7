module ApplicationHelper
  def formatted_date(date)
    date.strftime("%A, %B %-d, %Y")
  end
end
