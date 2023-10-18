class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action do # ActiveStorageのurlメソッドを使用できるようにする
    ActiveStorage::Current.host = request.base_url
  end


  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
