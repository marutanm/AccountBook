require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class SpendTest < Test::Unit::TestCase
  context "Spend Model" do
    should 'construct new instance' do
      @spend = Spend.new
      assert_not_nil @spend
    end
  end
end
