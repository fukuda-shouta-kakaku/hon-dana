module ApplicationHelper
  def is_user_context
    logged_in? && controller.controller_name == "users"
  end
end
