defmodule ContactCrudBackEnd.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ContactCrudBackEndWeb.Telemetry,
      ContactCrudBackEnd.Repo,
      {DNSCluster,
       query: Application.get_env(:contact_crud_back_end, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ContactCrudBackEnd.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ContactCrudBackEnd.Finch},
      # Start a worker by calling: ContactCrudBackEnd.Worker.start_link(arg)
      # {ContactCrudBackEnd.Worker, arg},
      # Start to serve requests, typically the last entry
      ContactCrudBackEndWeb.Endpoint,
      {Absinthe.Subscription, ContactCrudBackEndWeb.Endpoint},
      AshGraphql.Subscription.Batcher
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ContactCrudBackEnd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ContactCrudBackEndWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
