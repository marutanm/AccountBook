class Spend
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :uid, :type => String
  field :isSpend, :type => Boolean
  field :ammount, :type => Integer
  field :current, :type => Integer
  field :comment, :type => String

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>

  def self.create_new_document(params)
      create!(uid: "temp") do |db|
          db.ammount = params[:ammount]
          db.comment = params[:comment]
      end
  end

end
