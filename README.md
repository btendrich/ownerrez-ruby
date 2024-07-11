# Ownerrez::Ruby

TODO: Delete this and the text below, and describe your gem

Ruby wrapper for the [OwnerRez](https://www.ownerrez.com/) API v2. Built against the specs provided [here](https://www.ownerrez.com/support/articles/api-overview). Uses the OAuth2 gem to handle the authentication side.

## Installation

Since this is still in acvite early development it's not released as a gem. Install at your own risk.

## Usage

```
require 'ownerrez'
$or = OwnerRez::Connection.new( client_id: ENV['OWNERREZ_CLIENT_ID'], client_secret: ENV['OWNERREZ_CLIENT_SECRET'], redirect_uri: ENV['OWNERREZ_REDIRECT_URI'])
# => #<OwnerRez::Connection:0x00000001057441f8

# generate an authorization request link
$or.authorize_url
# => "https://appstage.ownerrez.com/oauth/authorize?client_id=c_stuff&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fownerrez_connection%2Fcallback&response_type=code"

# send the user there, receive callback with authorization code as payload, use that to request an access token:
token_set = $or.get_token( code )
# => { 'token_type' => 'bearer',
#      'scope' => 'all',
#      'user_id' => 123456789,
#      'user_display_name' => 'My Display Name',
#      'access_token' => 'at_foo',
#      'refresh_token' => nil,
#      'expires_at' => nil
#}

# save token_set for later reuse

# or restore from a stored token_set
$or.set_token_set(token_set)



# now request stuff
$or.get_properties()
# => [[#<OwnerRez::Model::Property:0x0000000121035148
#  @active=true,
#  @address=nil,
#  @bathrooms=0,
#  @bathrooms_full=0,
#  @bathrooms_half=0,
#  @bedrooms=0,
#  @check_in="16:00",
#  @check_in_end=nil,
#  @check_out="11:00",
#  @currency_code="USD",
#  @display_order=nil,
#  @external_display_order=nil,
#  @external_name=nil,
#  @fields=[],
#  @id=14140,
#  @internal_code=nil,
#  @key="d76a346e-5e82-4655-9b2a-fd4bbbbb8f24",
#  @latitude=nil,
#  @longitude=nil,
#  @max_adults=nil,
#  @max_children=nil,
#  @max_guests=0,
#  @max_pets=nil,
#  @name="Another Property",
#  @owner_id=nil,
#  @property_type=nil,
#  @public_url=nil,
#  @tags=[],
#  @thumbnail_url=nil,
#  @thumbnail_url_large=nil,
#  @thumbnail_url_medium=nil>]]


```

