# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ContactCrudBackEnd.Repo.insert!(%ContactCrudBackEnd.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

contacts = [
  %{name: "Gustavo Gomes", email: "gustavo@gmail.com", company: "Comando", phone: "15 99999-9999", photo_hash: "4867796b-492e-46eb-82d5-8c58e1046158"},
  %{name: "Linus Torvalds", email: "torvalds@linuxfoundation.org", company: "Linux Foundation", phone: "+1 (650) 123-4567", photo_hash: "a199fc54-47b3-4bbb-b940-6876682c37f1"},
  %{name: "Mark Zuckerberg", email: "zuck@meta.com", company: "Meta Platforms", phone: "+1 (650) 234-5678", photo_hash: "9ac8b4cb-ab2f-4dde-b58f-4d60f7e2f69c"},
  %{name: "Sam Altman", email: "sam@openai.com", company: "OpenAI", phone: "+1 (415) 987-6543", photo_hash: "450d0c9c-3800-4768-8595-2cdd821198e9"},
  %{name: "Zach Daniels", email: "zach@ash.com", company: "Ash", phone: "+1 (628) 456-7890", photo_hash: "1369a951-26e9-4f80-ab86-81283030fc3a"},
  %{name: "Alan Turing", email: "alan@bletchleypark.gov.uk", company: "Bletchley Park", phone: "+44 20 7946 0123", photo_hash: "8f397716-c17d-4d0c-8d9d-735a71f37173"},
  %{name: "Lian Wenfeng", email: "lian@antgroup.com", company: "Ant Group", phone: "+86 10 5678 1234", photo_hash: "512340f5-c58c-4788-9ed1-2d774791c4e5"},
  %{name: "Jeff Bezos", email: "jeff@blueorigin.com", company: "Amazon & Blue Origin", phone: "+1 (206) 123-4567", photo_hash: "dc8d7e40-d2e3-4873-a889-e30024e14d23"}
]

Enum.each(contacts, fn %{name: name, email: email, company: company, phone: phone, photo_hash: photo_hash} ->
  case ContactCrudBackEnd.Repo.get_by(ContactCrudBackEnd.List.Contact, email: email) do
    nil ->
      ContactCrudBackEnd.Repo.insert!(%ContactCrudBackEnd.List.Contact{name: name, email: email, company: company, phone: phone, photo_hash: photo_hash})
    _ -> :ok
  end
end)
