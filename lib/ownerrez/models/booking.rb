# frozen_string_literal: true

module OwnerRez
  module Model
    class Booking < Generic
      FIELDS = {
        adults: { type: Integer, required: true },
        arrival: { type: Date },
        booked_utc: {
          type: DateTime,
          parameter_name: 'booked'
        },
        canceled_utc: {
          type: DateTime,
          parameter_name: 'cancelled'
        },
        charges: {
          type: Array,
          subtype: OwnerRez::Model::BookingCharge
        },
        check_in: {},
        check_in_end: {},
        check_out: {},
        children: { type: Integer },
        cleaning_date: { type: Date },
        currency_code: {},
        departure: { type: Date },
        door_codes: {
          type: Array,
          subtype: OwnerRez::Model::BookingDoorCode
        },
        fields: {
          type: Array,
          subtype: OwnerRez::Model::FieldValue
        },
        form_key: {},
        guest: { type: OwnerRez::Model::GuestPartial },
        guest_id: { type: Integer },
        id: { type: Integer },
        infants: { type: Integer },
        is_block: {},
        listing_site: {},
        notes: {},
        owner_id: { type: Integer },
        pending_until_utc: {
          type: DateTime,
          parameter_name: 'pending_until'
        },
        pets: {},
        platform_email_address: {},
        platform_reservation_number: {},
        property_id: { type: Integer },
        quote_id: { type: Integer },
        status: {},
        tags: {
          type: Array,
          subtype: String
        },
        thread_ids: {
          type: Array,
          subtype: Integer
        },
        title: {},
        total_amount: {},
        total_host_fees: {},
        total_owed: {},
        total_paid: {},
        total_refunded: {},
        type: {}
      }.freeze
    end
  end
end
