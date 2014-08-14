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
        @id_sales = @client.create('Lead',
                            FirstName: pessoa[:first_name],
                            LastName: pessoa[:last_name],
                            Email: pessoa[:email],
                            Company: pessoa[:company],
                            Title: pessoa[:title],
                            Phone: pessoa[:phone],
                            Website: pessoa[:website])
      else
        false
      end
    end
    
    # def update_pessoa(pessoa)
    # end
    
    def remove_pessoa(salesforce_id)
      # client.destroy('Lead', salesforce_id)
    end
    
    def select_pessoas
      @pessoas = @client.query("select Id, FirstName, LastName, Email, Company, Title, Phone, Website from Lead")
    end
  end
end