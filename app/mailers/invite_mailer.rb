class InviteMailer < Merb::MailController
  
  def invite
    @user = params[:user]
    render_mail
  end  
  
end
