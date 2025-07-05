defmodule ContactCrudBackEnd.List.Contact do
  use Ash.Resource,
    otp_app: :contact_crud_back_end,
    domain: ContactCrudBackEnd.List,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type :contact

    queries do
      list :list_contact, :read
    end

    mutations do
      create :create_contact, :create
      update :update_contact, :update
      destroy :destroy_contact, :destroy
    end
  end

  postgres do
    table "contacts"
    repo ContactCrudBackEnd.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id
    attribute :name, :string, allow_nil?: false, public?: true
    attribute :phone, :string, allow_nil?: false, public?: true
    attribute :email, :string, allow_nil?: false, public?: true
    attribute :company, :string, allow_nil?: false, public?: true

    attribute :photo_hash, :string, allow_nil?: true, public?: true, default: ""
  end

  identities do
    identity :unique_email, [:email]
  end
end
