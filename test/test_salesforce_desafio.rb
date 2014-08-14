require 'helper'
require 'salesforce_desafio'

# class TestSalesforceDesafio < Test::Unit::TestCase
class TestSalesforceDesafio < MiniTest::Test
  def setup
    
    ###########################################################
    # OBS: alguns dos dados abaixo são dinâmico, pois depende 
    #      o salesforce ter uma conta logada.
    #      uma maneira de conseguir esses dados, logue no 
    #      site rdstation_desafio2, entre vá no banco de dados
    #      na tabela users e lá estará o dado do usuário logado.
    # OBS: ao testar, ele poderá criar dados na aba Lead da 
    #      conta logada. Então entre no site salesforce.com
    #      e vá na aba Lead e os dados testados estaram lá.
    ###########################################################
    @client = SalesforceDesafio::Client.new(
      "salesforce", #provider
      "https://login.salesforce.com/id/00Do0000000YIuVEAW/005o0000000PDClAAO", #uid
      "Jairo Tuboi", #name
      "00Do0000000YIuV!ASAAQPfR_qsTAAlVpGZCclXfqqAfvpTnsOeVQYINwjI1AjyDwEEv_ermQgxfL5_douIYkIxuCj2RxffcbQdgDa2racNLk7hP", #oauth_token
      "5Aep861LNDQReieQSKgyZjLrNBKLLyWXx0qweDjmBYLgHI1tgfsd7p2TpVWiinoGdPdHhR4aTRPOfWZYDMyp0qh", #refresh_token
      "https://na17.salesforce.com", #instance_url
      '3MVG9xOCXq4ID1uHwpuz_gk1vLP4qIlqZUzuspFZ14ufqz0481ZVt5ZTPEgaoW439Cqd8yQD1kTXJRLaaoQ3s', #client_id
      '5775174370761877174' #client_secret
    )
  end
  
  def test_add_pessoa
    id = @client.add_pessoa({first_name: "Jairo", last_name: "Tuboi", email: "jttuboi@gmail.com", company: "Tuboi", title: "chefe", phone: "123123123", website: "www.google.com"})
    assert(id.length == 18)
  end

  def test_add_pessoa_error_email
    id = @client.add_pessoa({first_name: "Jairo", last_name: "Tuboi", email: "jttuboi", company: "Tuboi", title: "chefe", phone: "123123123", website: "www.google.com"})
    assert_equal(false, id)
  end
  
  def test_add_pessoa_missing_last_name
    id = @client.add_pessoa({first_name: "Jairo", email: "jttuboi@gmail.com", company: "Tuboi", title: "chefe", phone: "123123123", website: "www.google.com"})
    assert_equal(false, id)
  end
  
  def test_add_pessoa_missing_company
    id = @client.add_pessoa({first_name: "Jairo", last_name: "Tuboi", email: "jttuboi@gmail.com", title: "chefe", phone: "123123123", website: "www.google.com"})
    assert_equal(false, id)
  end
    
  def test_add_pessoa_missing_email
    id = @client.add_pessoa({first_name: "Jairo", last_name: "Tuboi", company: "Tuboi", title: "chefe", phone: "123123123", website: "www.google.com"})
    assert(id.length == 18)
  end
  
  def test_add_pessoa_missing_title
    id = @client.add_pessoa({first_name: "Jairo", last_name: "Tuboi", email: "jttuboi@gmail.com", company: "Tuboi", phone: "123123123", website: "www.google.com"})
    assert(id.length == 18)
  end
  
  def test_select_pessoa
    result = @client.select_pessoas
    assert_instance_of(Restforce::Mash, result)
  end
end
