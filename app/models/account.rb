class Account
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :uid, :type => String
  field :name, :type => String
  field :nickname, :type => String
  field :role, :type => String, :default => "users"
  embeds_one :balance
  has_many :spends

  def self.create_with_omniauth(auth)
    create!( uid: auth["uid"],
            name: auth["user_info"]["name"],
           )
  end

  def self.find_or_create_with_omniauth(auth)
    account = find_or_create_by(uid: auth["uid"]) do |account|
      account.balance = Balance.new
    end
    account.name = auth["user_info"]["name"]
    account.nickname = auth["user_info"]["nickname"]
    account
  end

  def self.find_by_id(id)
    find(id) rescue nil
  end

  def add_new_spend(params)
    spends << Spend.create_new_document(params)
    balance.current = params[:category] == "expend" ?
      balance.current - params[:amount].to_i : params[:amount]
  end
end
