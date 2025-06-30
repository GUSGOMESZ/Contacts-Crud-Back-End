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
  %{name: "Gustavo Gomes", email: "gustavo@gmail.com", company: "Comando", phone: "15 99999-9999"},
  %{name: "Maria Silva", email: "maria.silva@techcorp.com", company: "TechCorp", phone: "11 98765-4321"},
  %{name: "Carlos Oliveira", email: "carlos.oliveira@inovatech.com", company: "InovaTech", phone: "21 99876-5432"},
  %{name: "Ana Paula Santos", email: "ana.santos@digitalmind.com", company: "DigitalMind", phone: "31 99123-4567"},
  %{name: "Pedro Costa", email: "pedro.costa@futurelabs.com", company: "FutureLabs", phone: "47 91234-5678"},
  %{name: "Juliana Ribeiro", email: "juliana.ribeiro@nexus.com", company: "Nexus Systems", phone: "19 98765-1234"},
  %{name: "Fernando Almeida", email: "fernando.almeida@quantum.com", company: "Quantum Solutions", phone: "11 91234-8765"},
  %{name: "Patrícia Lima", email: "patricia.lima@starlight.com", company: "Starlight Technologies", phone: "21 99876-1234"},
  %{name: "Ricardo Nunes", email: "ricardo.nunes@alphainnov.com", company: "Alpha Innovations", phone: "31 98765-4321"},
  %{name: "Amanda Costa", email: "amanda.costa@cybernet.com", company: "Cybernet Systems", phone: "47 91234-5678"},
  %{name: "Roberto Santos", email: "roberto.santos@megatech.com", company: "MegaTech", phone: "19 99876-5432"},
  %{name: "Beatriz Oliveira", email: "beatriz.oliveira@cloudnine.com", company: "CloudNine", phone: "11 91234-5678"},
  %{name: "Marcos Pereira", email: "marcos.pereira@digitalhub.com", company: "DigitalHub", phone: "21 98765-1234"},
  %{name: "Larissa Martins", email: "larissa.martins@infinitelabs.com", company: "Infinite Labs", phone: "31 99123-4567"},
  %{name: "Rodrigo Fernandes", email: "rodrigo.fernandes@newwave.com", company: "NewWave Technologies", phone: "47 91234-8765"},
  %{name: "Camila Gonçalves", email: "camila.goncalves@techvision.com", company: "TechVision", phone: "19 98765-4321"},
  %{name: "Felipe Ramos", email: "felipe.ramos@brightfuture.com", company: "BrightFuture Inc.", phone: "11 99876-1234"},
  %{name: "Tatiane Souza", email: "tatiane.souza@innovatech.com", company: "InnovaTech", phone: "21 91234-5678"},
  %{name: "Gabriel Castro", email: "gabriel.castro@digitalfront.com", company: "DigitalFront", phone: "31 98765-1234"},
  %{name: "Isabela Rocha", email: "isabela.rocha@nextgen.com", company: "NextGen Solutions", phone: "47 99123-4567"}
]

Enum.each(contacts, fn %{name: name, email: email, company: company, phone: phone} ->
  case ContactCrudBackEnd.Repo.get_by(ContactCrudBackEnd.List.Contact, email: email) do
    nil ->
      ContactCrudBackEnd.Repo.insert!(%ContactCrudBackEnd.List.Contact{name: name, email: email, company: company, phone: phone})
    _ -> :ok
  end
end)
