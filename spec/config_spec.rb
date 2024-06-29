# frozen_string_literal: true

# spec/property_spec.rb
require 'ownerrez'

describe OwnerRez::Connection do
  describe '#new' do
    it 'fails when called with no api_username/api_token or oauth_client_id parameters' do
      expect { OwnerRez::Connection.new }.to raise_error('no connection parameters provided')
    end
    it 'fails when provided a malformatted oauth_client_id' do
      expect { OwnerRez::Connection.new(oauth_client_id: 'foo') }.to raise_error('malformatted oauth client_id')
    end
    it 'suceeds when provided a valid oauth_client_id' do
      expect(OwnerRez::Connection.new(oauth_client_id: 'c_foo')).to be_a(OwnerRez::Connection)
    end
    it 'fails when called with only an api_username' do
      expect do
        OwnerRez::Connection.new(api_username: 'foo@bar.com')
      end.to raise_error('provided api_username but not api_token')
    end
    it 'fails when called with only an api_token' do
      expect do
        OwnerRez::Connection.new(api_token: 'pt_foobar')
      end.to raise_error('provided api_token but not api_username')
    end
    it 'fails when called with an invalid api_username' do
      expect do
        OwnerRez::Connection.new(api_username: 'foo', api_token: 'pt_foobar')
      end.to raise_error('malformatted api_username')
    end
    it 'fails when called with an invalid api_token' do
      expect do
        OwnerRez::Connection.new(api_username: 'foo@bar.com', api_token: 'foobar')
      end.to raise_error('malformatted api_token')
    end
    it 'suceeds when provided an api_username and api_token' do
      expect(OwnerRez::Connection.new(api_username: 'foo@bar.com',
                                      api_token: 'pt_foobar')).to be_a(OwnerRez::Connection)
    end
  end
end
