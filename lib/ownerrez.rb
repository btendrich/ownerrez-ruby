# frozen_string_literal: true

require 'bigdecimal'
require 'uri'
# require 'faraday'
require 'oauth2'

require_relative 'ownerrez/version'
require_relative 'ownerrez/errors'
require_relative 'ownerrez/helpers'
require_relative 'ownerrez/connection'

require_relative 'ownerrez/models/generic'

require_relative 'ownerrez/models/phone'
require_relative 'ownerrez/models/address'
require_relative 'ownerrez/models/email_address'
require_relative 'ownerrez/models/field_value'
require_relative 'ownerrez/models/guest'

require_relative 'ownerrez/models/booking_door_code'
require_relative 'ownerrez/models/booking_charge'
require_relative 'ownerrez/models/guest_partial'
require_relative 'ownerrez/models/booking'

require_relative 'ownerrez/models/property'

require_relative 'ownerrez/models/field'
require_relative 'ownerrez/models/field_definition'

module OwnerRez
  API_BASE_URI = 'https://api.ownerrez.com/v2/'
  OAUTH_AUTHORIZE_URI = 'https://app.ownerrez.com/oauth/authorize'
  OAUTH_TOKEN_URI = 'https://app.ownerrez.com/oauth/access_token'
end
