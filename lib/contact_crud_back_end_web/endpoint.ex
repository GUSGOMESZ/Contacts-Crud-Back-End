defmodule ContactCrudBackEndWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :contact_crud_back_end
  use Absinthe.Phoenix.Endpoint

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_contact_crud_back_end_key",
    signing_salt: "sCgCBsxr",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  socket "/ws/gql", ContactCrudBackEndWeb.GraphqlSocket, websocket: true, longpoll: true

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :contact_crud_back_end,
    gzip: false,
    only: ContactCrudBackEndWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug AshPhoenix.Plug.CheckCodegenStatus
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :contact_crud_back_end
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Corsica,
    origins: [
      "http://localhost:5173"
    ],
    allow_headers: ["accept", "content-type", "authorization"],
    allow_credentials: true,
    log: [rejected: :error, invalid: :warn, accepted: :debug]

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug ContactCrudBackEndWeb.Router
end
