
module Merb
  module InvitesHelper
    def yes_class(invite)
      "selected" if invite.accepted
    end
    def no_class(invite)
      "selected" if invite.accepted == false        and (!invite.accepted_at.blank? or !invite.declined_at.blank?)
    end
  end
  
end # Merb


