Kdkbook.controllers  do
  get :index do
    'Hello world!'
  end

  get :spend do
    @account = current_account
    render 'spend_form'
  end

  post :spend do
    current_account.add_new_spend(params)
    redirect url(:list, :id => current_account.nickname)
  end

  get :list do
    @account = current_account
    @documents = current_account.spends.desc(:updated_at)
    render 'spend_list'
  end

  get :list, :with => :id do
    @account = current_account
    @documents = params[:id] ?
      Account.where(nickname: params[:id]).first.spends : current_account.spends
    render 'spend_list'
  end

  get :login do
    haml <<-HAML.gsub(/^\s*/, '')
            Please login with
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
    account = Account.find_or_create_with_omniauth(auth)
    set_current_account(account)
    redirect "http://" + request.env["HTTP_HOST"] + url(:spend)
  end

end
