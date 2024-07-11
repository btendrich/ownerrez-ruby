# Ownerrez::Ruby

TODO: Delete this and the text below, and describe your gem

Ruby wrapper for the [OwnerRez](https://www.ownerrez.com/) API v2. Built against the specs provided [here](https://www.ownerrez.com/support/articles/api-overview). Uses the OAuth2 gem to handle the authentication side.

## Installation

Since this is still in acvite early development it's not released as a gem. Install at your own risk.

## Usage

```
require 'ownerrez'
$or = OwnerRez::Connection.new( client_id: ENV['OWNERREZ_CLIENT_ID'], client_secret: ENV['OWNERREZ_CLIENT_SECRET'], redirect_uri: ENV['OWNERREZ_REDIRECT_URI'])

# generate access token from code
token_set = $or.get_token( code )
# save token_set for later reuse_

$or.set_token_set(token_set)

$or.get_properties()

```

