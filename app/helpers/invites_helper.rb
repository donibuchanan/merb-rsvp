
module Merb
  module InvitesHelper
    def accept_message(accepted)
      state = accepted ? "accepted" : "declined"
      " has #{state} the invite"
    end
  end
  module InviteIncludes
    include InvitesHelper
    def accepted_message
      return "" if accepted_at.nil? and declined_at.nil?
      "#{name}" + accept_message(accepted)
    end
  end
end # Merb

Invite.send(:include, Merb::InviteIncludes)
