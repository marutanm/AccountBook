require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ControllerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  context "not authorized" do
    context "GET '/'" do
      setup do
        get '/'
      end

      should "return hello world text" do
        assert last_response.ok?
        assert_equal "Hello world!", last_response.body
      end
    end

    context "GET protected path" do
      setup do
        get '/spend'
        follow_redirect!
      end
      should "redirect to login" do
        assert last_response.ok?
        assert last_response.body =~ /Not logged in/
        assert last_response.body =~ /Please login with\n.*Twitter/
      end
    end

    context "GET unknown path" do
      setup { get '/unknown' }
      should "return 404" do
        assert !last_response.ok?
        assert_equal 404, last_response.status
      end
    end
  end

  context "authorize as test_user" do
    setup do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = {
        'uid' => '100',
        'user_info' => {
          'name' => 'foo bar',
          'nickname' => 'test_user'
        }
      }
      get '/auth/twitter'
      follow_redirect!
      follow_redirect!
    end
    should "display form" do
      assert last_response.ok?
      assert last_response.body =~ /Logined as/
    end      
  end

end
