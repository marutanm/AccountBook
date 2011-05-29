class Kdkbook < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    enable :sessions

    use OmniAuth::Builder do
        provider :twitter,  ENV['consumer_key'], ENV['consumer_secret']
    end

    set :login_page, "/login"

    access_control.roles_for :any do |role|
        role.protect "/spend"
        role.protect "/list"
    end

    access_control.roles_for :users do |role|
        role.allow "/spend"
        role.allow "/list"
    end

end
