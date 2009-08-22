module Admin
  class Users < Application
    before :ensure_admin
    def index
      provides :html, :csv
      @users = User.all
      render
    end

  private
    def ensure_admin
      unless (session.user.login =~ /^don|noomsy$/)
        redirect_to "/#{session.user.login}"
      end
    end
  end
end # Admin
