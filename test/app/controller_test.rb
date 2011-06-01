require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ControllerTest < Test::Unit::TestCase
  context "Contoller" do
    setup do
      get '/'
    end

    should "return hello world text" do
      assert_equal "Hello world!", last_response.body
    end
  end
end
