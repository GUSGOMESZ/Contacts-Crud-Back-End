defmodule ContactCrudBackEndWeb.GetProfilePhotoController do
  use ContactCrudBackEndWeb, :controller

  @pressigned_url_expires_in 3600

  def get_profile_photo(conn, %{"key" => key}) when is_binary(key) and key != "" do
    config = ExAws.Config.new(:s3)
    opts = [expires_in: @pressigned_url_expires_in]

    case ExAws.S3.presigned_url(config, :get, bucket(), key, opts) do
      {:ok, presigned_url} when is_binary(presigned_url) ->
        conn
        |> put_status(:ok)
        |> json(%{presigned_url: presigned_url})

      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Falha ao gertar URL pre assinada.", reason: reason})
    end
  end

  defp bucket(), do: "bucket-guoliv/contact-crud"
end
