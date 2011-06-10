require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class BalanceTest < Test::Unit::TestCase
  context "Balance Model" do
    should 'construct new instance' do
      @balance = Balance.new
      assert_not_nil @balance
      assert_equal 0, @balance.current
    end
  end
end
