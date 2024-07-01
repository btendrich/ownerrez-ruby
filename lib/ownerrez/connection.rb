# frozen_string_literal: true

require 'uri'
require 'faraday'

module OwnerRez
  class Connection
    attr_reader :api_username, :api_token, :oauth_client_id, :auth_type

    def initialize(api_username: nil, api_token: nil, oauth_client_id: nil)
      if oauth_client_id
        raise OwnerRez::Error, 'malformatted oauth client_id' unless oauth_client_id =~ /^c_.+$/

        @auth_type = :oauth
      elsif api_username || api_token
        raise OwnerRez::Error, 'provided api_username but not api_token' if api_username && !api_token
        raise OwnerRez::Error, 'provided api_token but not api_username' if api_token && !api_username
        raise OwnerRez::Error, 'malformatted api_username' unless api_username =~ URI::MailTo::EMAIL_REGEXP
        raise OwnerRez::Error, 'malformatted api_token' unless api_token =~ /^pt_.+$/

        @auth_type = :token
      else
        raise OwnerRez::Error, 'no connection parameters provided'
      end
      @api_username = api_username
      @api_token = api_token
      @oauth_client_id = oauth_client_id
    end

    def get_guest(id:)
      begin
        response = request(http_method: :get, endpoint: "guests/#{id.to_i}")
      rescue OwnerRez::ApiError404
        return nil
      end
      OwnerRez::Model::Guest.new(response[:body])
    end

    def get_guests(created_since_utc: nil, from: nil, include_fields: nil, include_tags: nil, q: '', to: nil)
      params = { created_since_utc:, from:, include_fields:,
                 include_tags:, q:, to: }
      request(http_method: :get, endpoint: 'guests', body: params.compact)

      #      OwnerRez::GuestModel.new(response[:body])
    end

    def get_booking(id:)
      response = request(http_method: :get, endpoint: "bookings/#{id.to_i}")
      OwnerRez::Model::Booking.new(response[:body])
    end

    private

    def client
      @client ||= begin
        options = {
          request: {
            open_timeout: 3,
            read_timeout: 3
          }
        }
        if auth_type == :token
          Faraday.new(url: OwnerRez::API_BASE_URL, **options) do |config|
            config.request :json
            config.response :json, parser_options: { symbolize_names: true }
            config.response :raise_error
            config.request :authorization, :basic, api_username, api_token
          end
        else
          Faraday.new(url: OwnerRez::API_BASE_URL, **options) do |config|
            config.request :json
            config.response :json, parser_options: { symbolize_names: true }
            config.response :raise_error
          end
        end
      end
    end

    def request(http_method:, endpoint:, body: {})
      response = client.public_send(http_method, endpoint, body)
      {
        status: response.status,
        body: response.body
      }
    rescue Faraday::ResourceNotFound
      raise OwnerRez::ApiError404
    rescue Faraday::Error => e
      raise OwnerRez::ApiError.new(
        message: e.message,
        faraday_error_class: e.class
      )
    end
  end
end
