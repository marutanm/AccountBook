Kdkbook.controllers  do
    get :index do
        'Hello world!'
    end

    get :spend do
        'spend'
    end

    get :list do
        'list'
    end

    get :login do
        haml <<-HAML.gsub(/^\s*/, '')
            Logins with
            =link_to('Twitter',  '/auth/twitter')
        HAML
    end

    get :profile do
        content_type :text
        current_account.to_yaml
    end

    get :destroy do
        set_current_account(nil)
        redirect url(:login)
    end

    get :auth, :map => '/auth/:provider/callback' do
        auth    = request.env["omniauth.auth"]
        account = Account.where(:uid => auth["uid"]).first || Account.create_with_omniauth(auth)
        set_current_account(account)
        redirect "http://" + request.env["HTTP_HOST"] + url(:spend)
    end

end
