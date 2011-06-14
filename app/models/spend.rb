class Spend
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :isSpend, :type => Boolean, :default => TRUE
  field :amount, :type => Integer
  field :comment, :type => String

  belongs_to :account

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>

  def self.create_new_document(params)
    create!(uid: params[:uid]) do |db|
      db.amount = params[:amount]
      db.comment = params[:comment]
      db.isSpend = params[:category] == "expend"
    end
  end

end
