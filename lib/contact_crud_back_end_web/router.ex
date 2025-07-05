defmodule ContactCrudBackEndWeb.Router do
  use ContactCrudBackEndWeb, :router

  pipeline :graphql do
    plug AshGraphql.Plug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ContactCrudBackEndWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/gql" do
    pipe_through [:graphql]

    forward "/playground", Absinthe.Plug.GraphiQL,
      schema: Module.concat(["ContactCrudBackEndWeb.GraphqlSchema"]),
      socket: Module.concat(["ContactCrudBackEndWeb.GraphqlSocket"]),
      interface: :simple

    forward "/", Absinthe.Plug, schema: Module.concat(["ContactCrudBackEndWeb.GraphqlSchema"])
  end

  scope "/api" do
    pipe_through :api

    get "/get_profile_photo", ContactCrudBackEndWeb.GetProfilePhotoController, :get_profile_photo

    post "/upload_profile_photo", ContactCrudBackEndWeb.UploadProfilePhotoController, :upload_profile_photo
  end

  scope "/", ContactCrudBackEndWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", ContactCrudBackEndWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:contact_crud_back_end, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ContactCrudBackEndWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
