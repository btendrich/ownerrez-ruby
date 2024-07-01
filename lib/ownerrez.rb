# frozen_string_literal: true
require 'bigdecimal'

require_relative 'ownerrez/version'
require_relative 'ownerrez/errors'
require_relative 'ownerrez/helpers'
require_relative 'ownerrez/connection'

require_relative 'ownerrez/models/generic'

require_relative 'ownerrez/models/phone'
require_relative 'ownerrez/models/address'
require_relative 'ownerrez/models/emailaddress'
require_relative 'ownerrez/models/fieldvalue'
require_relative 'ownerrez/models/guest'

require_relative 'ownerrez/models/bookingdoorcode'
require_relative 'ownerrez/models/bookingcharge'
require_relative 'ownerrez/models/guestpartial'
require_relative 'ownerrez/models/booking'

module OwnerRez
  API_BASE_URL = 'https://api.ownerrez.com/v2/'

end
