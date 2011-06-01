require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class AccountTest < Test::Unit::TestCase
  context "Account Model" do
    should 'construct new instance' do
      @account = Account.new
      assert_not_nil @account
    end
    should 'create with omniauth' do
      @auth = {:uid => "100", :name => "name"}
      assert_not_nil Account.create_with_omniauth(@auth)
    end
    should 'find by id' do
      assert_nil Account.find_by_id(:hoge)
    end
  end
end
