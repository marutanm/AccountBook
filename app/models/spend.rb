class Spend
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :uid, :type => String
  field :isSpend, :type => Boolean, :default => TRUE
  field :amount, :type => Integer
  field :current, :type => Integer
  field :comment, :type => String

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>

  def self.create_new_document(params)
    create!(uid: params[:uid]) do |db|
      db.amount = params[:amount]
      db.comment = params[:comment]
      case params[:category]
      when "expend"
        db.current = where(uid: params[:uid]) ?
        where(uid: params[:uid]).first.current.to_i - params[:amount] : params[:amount]
      when "current"
        db.current = params[:amount]
        db.isSpend = FALSE
      end
    end
  end

end
