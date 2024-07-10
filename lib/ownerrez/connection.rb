# frozen_string_literal: true

module OwnerRez
  class Connection
    attr_accessor :client_id, :client_secret, :redirect_uri, :client
    attr_reader :token

    def initialize(client_id:, client_secret:, redirect_uri:)
      raise OwnerRez::Error, 'malformatted client_id' unless client_id =~ /^c_.+$/
      raise OwnerRez::Error, 'malformatted client_secret' unless client_secret =~ /^s_.+$/
      raise OwnerRez::Error, 'malformatted redirect_uri' unless redirect_uri =~ URI::DEFAULT_PARSER.make_regexp

      @client_id = client_id
      @client_secret = client_secret
      @redirect_uri = redirect_uri

      @client = OAuth2::Client.new(@client_id, @client_secret,
                                   site: OwnerRez::API_BASE_URI,
                                   authorize_url: OwnerRez::OAUTH_AUTHORIZE_URI,
                                   token_url: OwnerRez::OAUTH_TOKEN_URI)
    end

    def authorize_url(**params)
      @client.auth_code.authorize_url(redirect_uri:, **params)
    end

    def get_token(code, **params)
      @token = @client.auth_code.get_token(code, redirect_uri:, **params)
    end

    def refresh_token_set
      @token.refresh!
    end

    def set_token_set(token_set)
      @token = OAuth2::AccessToken.new(@client, token_set.fetch('access_token'),
                                       refresh_token: token_set.fetch('refresh_token'))
    end

    def expired?
      return nil if @token.expires_at.nil? || Time.now.to_i > @token.expires_at
      true
    end

    def get_booking(id:)
      get_single(path: "bookings/#{id.to_i}", object: OwnerRez::Model::Booking)
    end

    def get_bookings(**params)
      get_multiple(path: 'bookings', object: OwnerRez::Model::Booking, params: params.compact)
    end
    
    def get_field_definitions(**params)
      get_multiple(path: 'fielddefinitions', object: OwnerRez::Model::FieldDefinition, params: params.compact)
    end
    
    def get_field_definition(id:)
      get_single(path: "fielddefinitions/#{id.to_i}", object: OwnerRez::Model::FieldDefinition)
    end
    
    def get_fields(**params)
      get_multiple(path: 'fields', object: OwnerRez::Model::Field, params: params.compact)
    end
    
    def get_field_definition(id:)
      get_single(path: "fields/#{id.to_i}", object: OwnerRez::Model::Field)
    end

    def get_property(id:)
      get_single(path: "properties/#{id.to_i}", object: OwnerRez::Model::Property)
    end

    def get_properties(**params)
      get_multiple(path: 'properties', object: OwnerRez::Model::Property, params: params.compact)
    end
    
    def get_guest(id:)
      get_single(path: "guests/#{id.to_i}", object: OwnerRez::Model::Guest)
    end

    def get_guests(**params)
      get_multiple(path: 'guests', object: OwnerRez::Model::Guest, params: params.compact)
    end
    



    private

    def get_single(path:, object:, params: {})
      response = token.get(path, params:)
      object.new(JSON.parse(response.body, symbolize_names: true))
    end

    def get_multiple(path:, object:, params: {}, maximum: 20)
      @objects = []

      while path
        response = JSON.parse( token.get(path, params: params).body, symbolize_names: true )
        @objects.push( *response.fetch(:items, []).map{ |item| object.new(item) } )
        path = response.fetch(:next_page_url, nil)
        break if @objects.count >= maximum
      end
      return @objects
    end

    def authenticated_get(endpoint, **params)
      access_token.get(endpoint, params:).parsed
    end

    def access_token
      raise OwnerRez::Error, 'No access token. Perform OAuth2 authorization first.' unless @token

      OAuth2::AccessToken.new(@client, @token)
    end

    def request(http_method:, endpoint:, body: {}); end
  end
end
