# frozen_string_literal: true

# spec/property_spec.rb
require 'ownerrez'

describe OwnerRez::Connection do
  subject(:connection) do
    described_class.new(api_username: ENV['API_USERNAME'], api_token: ENV['API_TOKEN'],
                        oauth_client_id: ENV['oauth_client_id'])
  end
  describe '#get_guest(id:)' do
    #    it 'returns status code 200 when valid guest record is received' do
    #      result = VCR.use_cassette('guest_200') do
    #        connection.get_guest(id: 613_782_149)
    #      end
    #      expect(result[:status]).to eq 200
    #    end
    #    it 'raises a 404 when the guest id is not found' do
    #      expect do
    #        VCR.use_cassette('guest_404') do
    #          connection.get_guest(id: 1)
    #        end
    #      end.to raise_error(an_instance_of(OwnerRez::ApiError).and(having_attributes(message: 'the server responded with status 404')))
    #    end
  end
end
