Kdkbook.controllers  do

    get :spend do
        render 'spend_form'
    end

    post :spend do
        Spend.create_new_document(params)
        redirect url(:list)
    end

    get :list do
        @documents = Spend.where(:uid => "temp").desc(:created_at)
        render 'spend_list'
    end

    # get :index, :map => "/foo/bar" do
    #   session[:foo] = "bar"
    #   render 'index'
    # end

    # get :sample, :map => "/sample/url", :provides => [:any, :js] do
    #   case content_type
    #     when :js then ...
    #     else ...
    # end

    # get :foo, :with => :id do
    #   "Maps to url '/foo/#{params[:id]}'"
    # end

    # get "/example" do
    #   "Hello world!"
    # end


end
