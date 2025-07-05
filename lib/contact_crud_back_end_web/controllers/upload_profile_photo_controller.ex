defmodule ContactCrudBackEndWeb.UploadProfilePhotoController do
  use ContactCrudBackEndWeb, :controller

  def upload_profile_photo(conn, params) do
    IO.inspect(params)

    photo = params["photo"]
    hash = params["hash"]

    # s3_object_key = photo.filename

    case upload_to_s3(photo.path, bucket(), hash, photo.content_type) do
      {:ok, s3_url} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Upload bem-sucedido.", fileUrl: s3_url})

      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Falha ao enviar o arquivo para S3.", reason: reason})
    end
  end

  defp upload_to_s3(local_path, bucket, key, content_type) do
    case File.read(local_path) do
      {:ok, file_content} ->
        operation = ExAws.S3.put_object(bucket, key, file_content, content_type: content_type)

        case ExAws.request(operation) do
          {:ok, %{status_code: 200}} ->
            s3_url = "https://#{bucket}.s3.sa-east-1.amazonaws.com/#{key}"
            {:ok, s3_url}

          {:ok, response} ->
            {:error, "Resposta inesperada: #{response}"}

          {:error, reason} ->
            {:error, reason}
        end

      {:error, reason} ->
        {:error, "Erro ao ler arquivo: #{reason}"}
    end
  end

  defp bucket(), do: "bucket-guoliv/contact-crud"
end
