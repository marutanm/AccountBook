class Account
    include Mongoid::Document
    include Mongoid::Timestamps # adds created_at and updated_at fields

    # field <name>, :type => <type>, :default => <value>
    field :name, :type => String
    field :uid, :type => String
    field :role, :type => String, :default => "users"

    def self.create_with_omniauth(auth)
        create!( uid: auth["uid"],
                name: auth["name"],
               )
    end

    def self.find_or_create_with_omniauth(auth)
      find_or_create_by(uid: auth["uid"], name: auth["name"]) do |account|
        account.name = auth["name"]
      end
    end

    def self.find_by_id(id)
        find(id) rescue nil
    end

end
