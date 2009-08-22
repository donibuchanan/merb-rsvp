module Merb
  module Admin
    module UsersHelper

      def display_response(invite)
        case 
          when (invite.accepted and invite.accepted_at)
            'yes'
          when (invite.declined_at)
            'no'
          else
            'NA'
        end
      end
    end
  end # Admin
end # Merb
