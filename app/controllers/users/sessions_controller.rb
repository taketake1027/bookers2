class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    flash[:notice] = "Signed in successfully."
    super(resource)
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "Signed out successfully."
    root_path # リダイレクト先を指定
  end
end
