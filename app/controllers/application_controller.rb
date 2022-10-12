class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    plans_path
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
    def record_not_found
      render template: "layouts/error", status: 404
      # render plain: "404 Not Found", status: 404
    end
end
