require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class SpendTest < Test::Unit::TestCase
  context "Spend Model" do
    context "create_new_document" do
      context "spend" do
        setup do
          @params = {:uid => "100", 
            :amount => 1000,
            :comment => "this is comment",
            :category => "expend"}
          @spend = Spend.create_new_document(@params)
        end
        should "return created document" do
          assert_equal @params[:uid], @spend.uid
          assert_equal @params[:amount], @spend.amount
          assert_equal @params[:comment], @spend.comment
          assert @spend.isSpend
        end
      end

      context "renew current balance" do
        setup do
          @params = {:uid => "100", 
            :amount => 1000,
            :comment => "this is comment",
            :category => "current"}
          @spend = Spend.create_new_document(@params)
        end
        should "return created document" do
          assert_equal @params[:uid], @spend.uid
          assert_equal @params[:amount], @spend.amount
          assert_equal @params[:amount], @spend.current
          assert_equal @params[:comment], @spend.comment
          assert !@spend.isSpend
        end
      end

    end
  end
end
