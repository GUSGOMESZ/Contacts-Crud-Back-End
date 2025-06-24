defmodule ContactCrudBackEnd.List do
  use Ash.Domain,
    otp_app: :contact_crud_back_end

  resources do
    resource ContactCrudBackEnd.List.Contact
  end
end
