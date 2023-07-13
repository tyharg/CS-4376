class ApplicationController < ActionController::Base

    def is_admin
        unless current_user && current_user.is_admin?
            redirect_to controller: 'url_entries', action: 'index', notice: "forbidden"
            # redirect_to :index, flash: {errors: "Forbidden"}
        end

    end
end
