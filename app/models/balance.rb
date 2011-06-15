class Balance
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :current, :type => Integer, :default => 0
  embedded_in :account

end
