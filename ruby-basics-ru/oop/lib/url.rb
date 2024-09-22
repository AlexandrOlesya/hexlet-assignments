# frozen_string_literal: true

require 'forwardable'
require 'uri'
require 'cgi'

class Url
    extend Forwardable
    include Comparable

    def_delegators :parsed_url, :host, :scheme, :port

    def initialize(str)
        @url = str
    end

    def query_params
        puts parsed_url.query
        params = CGI.parse(parsed_url.query.to_s)

        params.transform_keys(&:to_sym).transform_values { |v| v[0]}
    end
    
    def query_param(key_comparable, value = nil)
        query_params.each_key do |key|
            return query_params[key] if key == key_comparable
        end

        value
    end

    def <=>(other)
        [host, scheme, port, query_params] <=> [other.host, other.scheme, other.port, other.query_params]
    end

    private

    def parsed_url
        URI.parse(@url)
    end    
end
