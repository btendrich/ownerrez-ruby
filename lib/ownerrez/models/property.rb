# frozen_string_literal: true

module OwnerRez
  module Model
    class Property < Generic
      FIELDS = {
        active: { type: TrueClass },
        address: { type: OwnerRez::Model::Address },
        bathrooms: { type: Integer },
        bathrooms_full: { type: Integer },
        bathrooms_half: { type: Integer },
        bedrooms: { type: Integer },
        check_in: {},
        check_in_end: {},
        check_out: {},
        currency_code: {},
        display_order: { type: Integer },
        external_display_order: { type: Integer },
        external_name: {},
        fields: {
          type: Array,
          subtype: OwnerRez::Model::FieldValue
        },
        id: { type: Integer },
        internal_code: {},
        key: {},
        latitude: {},
        longitude: {},
        max_adults: { type: Integer },
        max_children: { type: Integer },
        max_guests: { type: Integer },
        max_pets: { type: Integer },
        name: {},
        owner_id: { type: Integer },
        property_type: {},
        public_url: {},
        tags: {
          type: Array,
          subtype: String
        },
        thumbnail_url: {},
        thumbnail_url_large: {},
        thumbnail_url_medium: {}
      }.freeze
    end
  end
end
