# frozen_string_literal: true

module OwnerRez
  module Model
    class Guest < Generic
      FIELDS = {
        addresses: {
          type: Array,
          subtype: OwnerRez::Model::Address
        },
        email_addresses: {
          type: Array,
          subtype: OwnerRez::Model::EmailAddress
        },
        fields: {
          type: Array,
          subtype: OwnerRez::Model::FieldValue
        },
        phones: {
          type: Array,
          subtype: OwnerRez::Model::Phone
        },
        first_name: {},
        id: { type: Integer },
        last_name: {},
        notes: {},
        tags: {
          type: Array,
          subtype: String
        }
      }.freeze
    end
  end
end
