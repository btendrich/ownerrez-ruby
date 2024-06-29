# frozen_string_literal: true

module OwnerRez
  module Model
    class GuestPartial < Generic
      FIELDS = {
        first_name: {},
        id: { type: Integer },
        last_name: {}
      }.freeze
    end
  end
end
