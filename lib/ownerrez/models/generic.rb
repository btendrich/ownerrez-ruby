# frozen_string_literal: true

module OwnerRez
  module Model
    class Generic
      # default class variable of empty fields
      FIELDS = {}.freeze

      def initialize(data)
        raise OwnerRez::Error, "trying to initialize with '#{data.inspect}'" unless data.respond_to? :each

        # iterate through passed data hash
        data.each_key do |key|
          # raise error if there is data that doesn't corrispond with a defined field
          raise OwnerRez::Error, "unknown data field #{key}" unless self.class::FIELDS.key? key
        end

        # grab the class variable and iterate through it
        self.class::FIELDS.each do |field, field_info|
          # if this is a required field, check if it exists in the passed data hash
          if field_info.fetch(:required, nil) && !(data.key? field)
            raise OwnerRez::Error, "missing required field #{field}"
          end

          # set the value of the field to the value returned by Faraday (or nil if it doesn't exist) by default
          unmapped_value = data.fetch(field, nil)

          parameter_name = field_info.fetch(:parameter_name, field.to_s)
          field_type = field_info.fetch(:type, nil)
          field_type = String if field_type.nil?

          # if there is a value set, parse it (otherwise leave it empty)
          if unmapped_value
            case field_type.to_s
            when 'Array'
              # if the defined field type is an array process it into an array of the subobjects

              # array starts empty
              value = []

              # iterate through the array returned by faraday
              data.fetch(field, []).each do |item_data|
                # instantiate new objects of the type defiend in the field information in the parent model, and pass them the hash given to us of their value(s)
                value << if field_info.fetch(:subtype, nil) == Integer
                           item_data.to_i
                         else
                           field_info[:subtype].new(item_data)
                         end
              end
            when 'TrueClass'
              # if the defiend field type is boolean, set the value depending on the string value of the field in question
              value = data.fetch(field, 'false').to_s == 'true' ? true : nil

            when 'Integer'
              # if the defined field type is integer, set the value to the integer interpretation of the string -- unless it's nil, in which case preserve nil
              value = unmapped_value.to_i

            when 'Date'
              # if the defiened field type is a date, parse the date into a ruby date object and use that
              begin
                value = Date.parse(unmapped_value)
              rescue Date::Error
                raise OwnerRez::Error, "unable to parse date #{unmapped_value.inspect}"
              end

            when 'DateTime'
              # if the defiened field type is a datetime, parse the date into a ruby date object and use that
              begin
                value = DateTime.parse(unmapped_value)
              rescue Date::Error
                raise OwnerRez::Error, "unable to parse datetime #{unmapped_value.inspect}"
              end

            when 'BigDecimal'
              # if the defiened field type is a datetime, parse the date into a ruby date object and use that
              value = BigDecimal(unmapped_value.to_s)

            when 'String'
              value = unmapped_value.to_s

            else
              # default to just calling #new() on the provided object type and let the object coerce it itself
              value = field_type.public_send(:new, unmapped_value)
            end
          end

          # set the applicable instance variable to the value we've determined for this field
          instance_variable_set("@#{parameter_name}", value)

          # abuse the helper method to create an accessor method for the instance variable for this field
          self.class.send(:attr_reader, parameter_name)
        end
      end
    end
  end
end
