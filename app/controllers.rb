Kdkbook.controllers  do
  before do
    @account = current_account
  end

  get :index do
    'Hello world!'
  end

  get :spend do
    render 'spend_form'
  end

  post :spend do
    current_account.add_new_spend(params)
    redirect url(:list, :id => current_account.nickname)
  end

  get :list do
    @documents = current_account.spends.desc(:updated_at)
    render 'spend_list'
  end

  get :list, :with => :id do
    case params[:id] 
    when current_account.nickname
      redirect :list
    else
      authorized_user = Account.where(nickname: params[:id]).first[:authorized_user] rescue Array.new
      if authorized_user.include?(@account.nickname)
        @documents = Account.where(nickname: params[:id]).first.spends
        render 'spend_list'
      else
        status 403
        "Forbidden"
      end
    end
  end

  get :authorize do
    @authorized = current_account.authorized_user
    render 'authorize_form'
  end

  post :authorize do
    current_account.authorize(params[:authorize])
    redirect url :authorize
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
    redirect url :login
  end

  get :auth, :map => '/auth/:provider/callback' do
    auth    = request.env["omniauth.auth"]
    account = Account.find_or_create_with_omniauth(auth)
    set_current_account(account)
    redirect url :spend
  end

end
