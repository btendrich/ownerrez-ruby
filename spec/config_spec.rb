# frozen_string_literal: true

# spec/property_spec.rb
require 'ownerrez'

describe OwnerRez::Connection do
  describe '#new' do
    it 'fails when called with no client_id' do
      expect do
        OwnerRez::Connection.new(client_secret: 's_foo',
                                 redirect_uri: 'http://localhost/callback')
      end.to raise_error('missing keyword: :client_id')
    end
    it 'fails when called with no client_secret' do
      expect do
        OwnerRez::Connection.new(client_id: 'c_foo',
                                 redirect_uri: 'http://localhost/callback')
      end.to raise_error('missing keyword: :client_secret')
    end
    it 'fails when called with no redirect_uri' do
      expect do
        OwnerRez::Connection.new(client_id: 'c_foo', client_secret: 's_foo')
      end.to raise_error('missing keyword: :redirect_uri')
    end

    it 'fails when provided a malformatted client_id' do
      expect do
        OwnerRez::Connection.new(client_id: 'X_foo', client_secret: 's_foo',
                                 redirect_uri: 'http://localhost/callback')
      end.to raise_error('malformatted client_id')
    end
    it 'fails when provided a malformatted client_secret' do
      expect do
        OwnerRez::Connection.new(client_id: 'c_foo', client_secret: 'X_foo',
                                 redirect_uri: 'http://localhost/callback')
      end.to raise_error('malformatted client_secret')
    end
    it 'fails when provided a malformatted redirect_uri' do
      expect do
        OwnerRez::Connection.new(client_id: 'c_foo', client_secret: 's_foo',
                                 redirect_uri: 'foo')
      end.to raise_error('malformatted redirect_uri')
    end
    it 'succeeds when provided correctly formatted parameters' do
      expect(OwnerRez::Connection.new(client_id: 'c_foo', client_secret: 's_foo',
                                      redirect_uri: 'http://localhost')).to be_a(OwnerRez::Connection)
    end
  end
end
