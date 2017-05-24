module Concerns
  module Nerpatship
    module NerpatRequest
      NERGE_REQUEST_MSG = "muốn nhận bạn làm Nerge"
      PATRON_REQUEST_MSG = "muốn nhận bạn làm Patron"

      def pending_nerpats
        ids = Notification.nerpat_requests
          .where(actor: self).pluck(:recipient_id)
        User.where(id: ids)
      end

      def requested_nerpats
        ids = notifications.nerpat_requests.pluck(:actor_id)
        User.where(id: ids)
      end

      def nerge_request_with?(user)
        Notification.find_by actor: self, recipient: user,
          action: NERGE_REQUEST_MSG
      end

      def nerpat_request_to(nerpat, type)
        nerpat.notifications.find_or_create_by actor: self, notifiable: self,
          action: Concerns::Nerpatship::NerpatRequest
                    .const_get("#{type.upcase}_REQUEST_MSG")
      end

      def decline_nerpat_request_from(nerpat, type)
        msg = (type == 'nerge' ? 'PATRON' : 'NERGE') + '_REQUEST_MSG'

        notifications.find_by(actor: nerpat,
          action: Concerns::Nerpatship::NerpatRequest.const_get(msg)
        ).try(:destroy)
      end

      def cancel_nerpat_request_to(nerpat, type)
        decline_type = (type == 'nerge' ? 'patron' : 'nerge')
        nerpat.decline_nerpat_request_from(self, decline_type) 
      end

      def accept_nerpat_request_from(nerpat, type)
        unless decline_nerpat_request_from(nerpat, type) 
          raise ActiveRecord::RecordNotFound
        end

        type == 'nerge' ? self.nerges << nerpat : nerpat.nerges << self

        nerpat.notifications.create actor: self, notifiable: self,
          action: "đã đồng ý nhận bạn làm #{type.upcase_first}"
        decline_nerpat_request_from(nerpat, type)
      end
    end
  end
end
