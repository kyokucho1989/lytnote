class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    plans_path
  end

  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found
  
  def page_not_found
    render template: "layouts/error", status: 404
  end
  
end
