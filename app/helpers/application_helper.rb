module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http') ? url : "http://#{url}"
  end

  def display_datetime(dt)
    dt = dt.in_time_zone(current_user.time_zone) if logged_in?
    dt.strftime("%b %d, %Y @ %l:%M%P %Z")
  end
end
