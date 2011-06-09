require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class AccountTest < Test::Unit::TestCase
  context "Account Model" do

    context "create_with_omniauth" do
      setup do
        @auth = {"uid" => "100",
           "user_info" => {"name" => "testuser"} }
        @account = Account.create_with_omniauth(@auth)
      end
      should "return created document" do
        assert_equal Account, @account.class
        assert_equal @auth["uid"], @account.uid
        assert_equal @auth["user_info"]["name"], @account.name
        assert_equal "users", @account.role
      end
      teardown do
        Account.delete_all
      end
    end

    context "find_or_create_with_omniauth" do
      context "account not registerd" do
        setup do
          @auth = {"uid" => "100",
            "user_info" => {"name" => "testuser"} }
          @account = Account.find_or_create_with_omniauth(@auth)
        end
        should "create and return document" do
          assert_equal Account, @account.class
          assert_equal @auth["uid"], @account.uid
          assert_equal @auth["user_info"]["name"], @account.name
          assert_equal "users", @account.role
        end
      end
      context "account already registerd" do
        setup do 
          @auth = {"uid" => "100",
            "user_info" => {"name" => "testuser"} }
          Account.create_with_omniauth(@auth)
          @auth = {"uid" => "100",
            "user_info" => {"name" => "modifieduesr"} }
          @account = Account.find_or_create_with_omniauth(@auth)
        end
        should "find and return exsitance document" do
          assert_equal Account, @account.class
          assert_equal @auth["uid"], @account.uid
          assert_equal @auth["user_info"]["name"], @account.name
          assert_equal "users", @account.role
          assert_equal 2, Account.count
        end
        teardown do
          Account.delete_all
        end
      end
    end

  end
end
