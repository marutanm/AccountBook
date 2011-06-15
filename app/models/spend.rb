class Spend
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :amount, :type => Integer
  field :comment, :type => String
  field :isSpend, :type => Boolean, :default => TRUE

  belongs_to :account

  def self.create_new_document(params)
    create!( amount: params[:amount],
            comment: params[:comment],
            isSpend: params[:category] == "expend")
  end

end
