require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ControllerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  context "GET '/'" do
    setup do
      get '/'
    end

    should "return hello world text" do
      assert last_response.ok?
      assert_equal "Hello world!", last_response.body
    end
  end

  context "GET unknown path" do
    setup do
      get '/unknown'
    end
    should "return 404" do
      assert !last_response.ok?
      assert_equal 404, last_response.status
    end
  end

end
