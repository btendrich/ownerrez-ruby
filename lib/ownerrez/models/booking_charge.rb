# frozen_string_literal: true

module OwnerRez
  module Model
    class BookingCharge < Generic
      FIELDS = {
        amount: {},
        commission_amount: {},
        description: {},
        expense_id: { type: Integer },
        is_channel_managed: { type: TrueClass },
        is_commission_all: { type: TrueClass },
        is_expense_all: { type: TrueClass },
        is_taxable: { type: TrueClass },
        owner_amount: {},
        owner_commission_percent: {},
        position: { type: Integer },
        rate: {},
        rate_is_percent: { type: TrueClass },
        surcharge_id: { type: Integer },
        tax_id: { type: Integer },
        type: {}
      }.freeze
    end
  end
end
