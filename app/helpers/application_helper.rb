module ApplicationHelper
  def is_user_context
    controller.controller_name == "users"
  end
end
