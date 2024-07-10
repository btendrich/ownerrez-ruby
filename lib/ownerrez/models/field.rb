# frozen_string_literal: true

module OwnerRez
  module Model
    class Field < Generic
      FIELDS = {
        entity_id: { type: Integer },
        entity_type: {},
        field_definition_id: { type: Integer },
        id: { type: Integer, required: true },
        value: {}
      }.freeze
    end
  end
end
