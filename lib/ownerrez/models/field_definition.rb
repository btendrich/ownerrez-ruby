# frozen_string_literal: true

module OwnerRez
  module Model
    class FieldDefinition < Generic
      FIELDS = {
        code: {},
        description: {},
        full_code: {},
        id: { type: Integer, required: true },
        name: {},
        type: {},
      }.freeze
    end
  end
end
