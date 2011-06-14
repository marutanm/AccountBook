require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class SpendTest < Test::Unit::TestCase
  context "Spend Model" do
    context "create_new_document" do
      setup do
        @account = Account.new( name: "account name", uid: "1192")
      end

      context "spend first time" do
        setup do
          @params = {:amount => 1000,
            :comment => "this is comment",
            :category => "expend"}
          @spend = Spend.create_new_document(@params)
          @spend.account = @account
        end
        should "return created document" do
          assert_equal @params[:amount], @spend.amount
          assert_equal @params[:comment], @spend.comment
          assert @spend.isSpend
          assert_equal @account, @spend.account
        end
      end

      context "spend " do
        setup do
          @params = {:amount => 2000,
            :comment => "this is comment part two",
            :category => "expend"}
          @spend = Spend.create_new_document(@params)
          @spend.account = @account
        end
        should "return created document" do
          assert_equal @params[:amount], @spend.amount
          assert_equal @params[:comment], @spend.comment
          assert @spend.isSpend
          assert_equal @account, @spend.account
          assert_equal 2, Spend.count
        end
        teardown do
          Spend.delete_all
        end
      end

      context "renew current balance" do
        setup do
          @params = { :amount => 1000,
            :comment => "this is comment",
            :category => "current"}
          @spend = Spend.create_new_document(@params)
          @spend.account = @account
        end
        should "return created document" do
          assert_equal @params[:amount], @spend.amount
          assert_equal @params[:comment], @spend.comment
          assert !@spend.isSpend
          assert_equal @account, @spend.account
        end
        teardown do
          Spend.delete_all
        end
      end

    end
  end
end
