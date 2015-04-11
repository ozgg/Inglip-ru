module ApplicationHelper
  def param_from_request(parameter)
    params[parameter].to_s.encode('UTF-8', 'UTF-8', invalid: :replace, replace: '')
  end
end
