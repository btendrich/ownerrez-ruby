# frozen_string_literal: true

module OwnerRez
  module Model
    class EmailAddress < Generic
      FIELDS = {
        address: {},
        id: { type: Integer },
        is_default: { type: TrueClass },
        type: {}
      }.freeze
    end
  end
end
