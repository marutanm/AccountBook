class Account
    include Mongoid::Document
    include Mongoid::Timestamps # adds created_at and updated_at fields

    # field <name>, :type => <type>, :default => <value>
    field :name, :type => String
    field :uid, :type => String
    field :role, :type => String

    def self.create_with_omniauth(auth)
        create!( uid: auth["uid"],
                name: auth["name"],
                role: "users"
               )
    end

    def self.find_by_id(id)
        find(id) rescue nil
    end

end
