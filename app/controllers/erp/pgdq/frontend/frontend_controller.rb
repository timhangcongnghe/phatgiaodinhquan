require_dependency "erp/application_controller"
module Erp::Frontend
  class FrontendController < Erp::ApplicationController
    include Erp::ApplicationHelper
    before_action :redirect_subdomain

    def redirect_subdomain
      if request.host == 'www.phatgiaodinhquan.org'
        redirect_to 'https://phatgiaodinhquan.org' + request.fullpath, :status => 301
      end
    end
    
    layout 'erp/frontend/index'
    
    def current_ability
      @current_ability ||= Erp::Ability.new(current_user)
    end
  end
end