class Email < ApplicationRecord

    enum kind: { rejection_email: 0 }
    enum status: { pending: 0, sent: 1, failed: 2, delivered: 3, read: 4 }

    def title
        case kind
        when 0
            "Rejection Email"
        end
    end
end
