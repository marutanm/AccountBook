require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class AccountTest < Test::Unit::TestCase
  context "Account Model create new document" do
    setup do
      @auth = {"uid" => "100", "name" => "testuser"}
      @account = Account.create_with_omniauth(@auth)
    end

    should "return created document" do
      assert_not_nil @account
      assert_equal @auth["uid"], @account.uid
      assert_equal @auth["name"], @account.name
      assert_equal "users", @account.role
    end

    teardown do
      Account.delete_all
    end
  end
end
