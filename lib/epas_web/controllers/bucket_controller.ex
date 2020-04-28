defmodule EpasWeb.BucketController do
  use EpasWeb, :controller

  plug :audit_log

  def index(conn, _params) do
    buckets =
      ExAws.S3.list_buckets()
      |> ExAws.request!()
      |> get_in([:body, :buckets])

    render(conn, "index.html", buckets: buckets)
  end

  def show(conn, %{"path" => path}) do
    files =
      ExAws.S3.list_objects(path)
      |> ExAws.request!()
      |> get_in([:body, :contents])

    render(conn, "show.html", bucket: path, files: files)
  end

  def download(conn, %{"path" => path}) do
    [bucket | tail] = String.split(path, ">")
    file_name = extract_file_name(tail)
    tmp_file = "tmp/#{file_name}"

    try do
      ExAws.S3.download_file(bucket, Enum.join(tail, "/"), tmp_file)
      |> ExAws.request!()

      conn
      |> send_download({:file, tmp_file})
    catch
      x ->
        conn
        |> put_flash(:error, "Error to download this file #{file_name}. Message #{x}")
        |> redirect(to: Routes.bucket_path(conn, :show, bucket))
    after
      if File.exists?(tmp_file) do
        File.rm_rf!(tmp_file)
      end
    end
  end

  defp extract_file_name(tail) when length(tail) == 1, do: tail

  defp extract_file_name(tail), do: tl(tail)

  def delete(conn, %{"path" => path}) do
    [bucket | tail] = String.split(path, ">")

    ExAws.S3.delete_object(bucket, Enum.join(tail, "/"))
    |> ExAws.request!()

    conn
    |> put_flash(:info, "File Deleted")
    |> redirect(to: Routes.bucket_path(conn, :show, bucket))
  end

  def new(conn, %{"path" => path}) do
    render(conn, "new.html", path: path)
  end

  def create(conn, %{"path" => path, "upload" => %Plug.Upload{} = upload}) do
    [bucket | tail] = String.split(path, ">")

    {:ok, image_binary} = File.read(upload.path)

    ExAws.S3.put_object(bucket, Enum.join(tail, "/") <> upload.filename, image_binary)
    |> ExAws.request!()

    conn
    |> put_flash(:info, "File create")
    |> redirect(to: Routes.bucket_path(conn, :show, bucket))
  end

  def create(conn, %{"path" => path}) do
    conn
    |> put_flash(:error, "File required")
    |> redirect(to: Routes.bucket_path(conn, :new, path))
  end

  def audit_log(conn, _opts) do
    Epas.Account.create_log(%{
      operation: conn.method,
      user_id: conn.assigns.user.id,
      info: "request_path: #{conn.request_path}, path_info: #{conn.path_info}"
    })
    conn
  end
end
