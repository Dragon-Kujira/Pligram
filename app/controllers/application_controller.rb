class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def after_sign_in_path_for(resource)
    case resource
     when Admin
      admin_root_path
     when User
      my_page_path
    end
   end
 
   def after_sign_out_path_for(resource)
     root_path
   end

   def set_search
    #@search = Post.search(params[:q])
    @search = Post.ransack(params[:q]) #ransackメソッド推奨
    @search_posts = @search.result.page(params[:page])
  end

   protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  end
