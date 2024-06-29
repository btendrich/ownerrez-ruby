# frozen_string_literal: true

module OwnerRez
  module Model
    class Address < Generic
      FIELDS = {
        city: {},
        country: {},
        id: { type: Integer },
        is_default: { type: TrueClass },
        postal_code: {},
        province: {},
        state: {},
        street1: {},
        street2: {},
        type: {}
      }.freeze
    end
  end
end
