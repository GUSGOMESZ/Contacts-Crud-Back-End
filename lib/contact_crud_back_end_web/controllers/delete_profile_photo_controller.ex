defmodule ContactCrudBackEndWeb.DeleteProfilePhotoController do
  use ContactCrudBackEndWeb, :controller

  def delete_profile_photo(conn, params) do
    hash = params["hash"]

    case delete_from_s3(bucket(), hash) do
      {:ok, _} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "Foto deletada com sucesso."})

      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Falha ao deletar a foto do S3.", reason: reason})
    end
  end

  defp delete_from_s3(bucket, key) do
    operation = ExAws.S3.delete_object(bucket, key)

    case ExAws.request(operation) do
      {:ok, %{status_code: 204}} ->
        {:ok, "deleted"}

      {:ok, response} ->
        {:error, "Resposta inesperada: #{inspect(response)}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp bucket(), do: "bucket-guoliv/contact-crud"
end
