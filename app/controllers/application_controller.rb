class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  before_action :get_messages
  before_action :get_subdomain

  def render_401
    render :file => "public/401.html", :status => :unauthorized
  end

  def verify_admin
    unless current_user.admin?
      render :file => "public/401.html", :status => :unauthorized
    end
  end

  def verify_prof
    unless current_user.prof?
      render :file => "public/401.html", :status => :unauthorized
    end
  end

  def verify_super_admin
    unless current_user.super_admin?
      render :file => "public/401.html", :status => :unauthorized
    end
  end

  def get_messages
    if user_signed_in?
      @messages_to_me_top = current_user.last_messages_to_me(4)
      @n_new_messages = current_user.number_of_new_messages
    end
  end

  def verified_request?
    #p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    #p form_authenticity_token
    #p request.headers['X-CSRF-Token']
    super()
  end

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :prof) }
      # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :avatar) }
    end

    # Devise method overrided to change the redirect after sign in.
    # def after_sign_in_path_for(resource)
    #  authenticated_root_path
    # end

    def create_guest_user
      u = User.create(name: "Guest", email: "guest_#{Time.now.to_i}#{rand(99)}@example.com", guest: true)
      u.save!(:validate => false)
      session[:guest_user_id] = u.id
      u
    end

    # find guest_user object associated with the current session,
    # creating one as needed
    def guest_user
      # Cache the value the first time it's gotten.
      @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

      rescue Mongoid::Errors::DocumentNotFound # if session[:guest_user_id] invalid
        session[:guest_user_id] = nil
        guest_user
    end

    def get_subdomain
      @subdomain = ""
      @subdomain = "(#{request.subdomain.split('.').first.upcase})" unless request.subdomain == "" || request.subdomain == "farma-alg"
    end

    protected

    def layout_to_resource
      if devise_controller?
        "login"
      else
        "application"
      end
    end

     def ckeditor_filebrowser_scope(options = {})
       super({ :assetable_id => current_user.id, :assetable_type => 'User' }.merge(options))
     end
end
