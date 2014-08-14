require 'pry'
require 'omniauth-salesforce'
require 'restforce'

module SalesforceDesafio
  class Client
      attr_reader :provider, :uid, :name, :oauth_token, :refresh_token, :instance_url, :client_id, :client_secret
      attr_reader :client

    def initialize(provider, uid, name, oauth_token, refresh_token, instance_url, client_id, client_secret)
      @provider = provider
      @uid = uid
      @name = name
      @oauth_token = oauth_token
      @refresh_token = refresh_token
      @instance_url = instance_url
      @client_id = client_id
      @client_secret = client_secret
      
      @client ||= Restforce.new :oauth_token => @oauth_token,
                                :refresh_token => @refresh_token,
                                :instance_url  => @instance_url,
                                :client_id     => @client_id,
                                :client_secret => @client_secret
    end
    
    # def client
      # @client ||= Restforce.new :oauth_token => @oauth_token,
                                # :refresh_token => @refresh_token,
                                # :instance_url  => @instance_url,
                                # :client_id     => @client_id,
                                # :client_secret => @client_secret
    # end
    
    def add_pessoa(pessoa)
      # last_name e company sao obrigatorios
      if (pessoa[:last_name] && pessoa[:company])
        @id = @client.create('Lead',
                            FirstName: pessoa[:first_name] ? pessoa[:first_name] : "",
                            LastName: pessoa[:last_name],
                            Email: pessoa[:email] ? pessoa[:email] : "",
                            Company: pessoa[:company],
                            Title: pessoa[:title] ? pessoa[:title] : "",
                            Phone: pessoa[:phone] ? pessoa[:phone] : "",
                            Website: pessoa[:website] ? pessoa[:website] : "")
      else
        false
      end
    end
    
    # def update_pessoa(pessoa)
    # end
#     
    # def remove_pessoa(pessoa)
    # end
    
    def select_pessoas
      @pessoas = @client.query("select Id, FirstName, LastName, Email, Company, Title, Phone, Website from Lead")
      @client.authenticate!
    end
  end
end