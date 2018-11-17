module ApplicationHelper
  def not_found
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
