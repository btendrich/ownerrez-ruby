# frozen_string_literal: true

module OwnerRez
  module Model
    class Phone < Generic
      FIELDS = {
        extension: {},
        id: { type: Integer },
        is_default: { type: TrueClass },
        number: {},
        type: {}
      }.freeze
    end
  end
end
