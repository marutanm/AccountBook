class Account
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :uid, :type => String
  field :name, :type => String
  field :nickname, :type => String
  field :image, :type => String
  field :role, :type => String, :default => "users"
  field :authorized_user, :type => Array, :default => Array.new
  embeds_one :balance
  has_many :spends

  def self.find_or_create_with_omniauth(auth)
    account = find_or_create_by(uid: auth["uid"]) do |account|
      account.balance = Balance.new
    end
    account.name = auth["user_info"]["name"]
    account.nickname = auth["user_info"]["nickname"]
    account.image = auth["user_info"]["image"]
    account.save
    account
  end

  def self.find_by_id(id)
    find(id) rescue nil
  end

  def add_new_spend(params)
    spends << Spend.create_new_document(params)
    params[:category] ||= :expend
    case params[:category]
    when :expend
      create_balance(current: balance.current - params[:amount].to_i)
    when :current
      create_balance(current: params[:amount])
    end
  end
  
  def authorize(id)
    authorized_user << id unless authorized_user.include?(id)
    save
  end
end
