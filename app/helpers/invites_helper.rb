
module Merb
  module InvitesHelper
    def yes_class(invite)
      "selected" if invite.accepted
    end
    def no_class(invite)
      "selected" unless invite.accepted
    end
  end
  
end # Merb


