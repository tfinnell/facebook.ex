defmodule Facebook.Messenger.Plug do
  @moduledoc """
  Facebook Messenger Platform webhook validation endpoint

  Example Usage In Phoenix:
    In your router add an entry such as

    `forward "/webhook", Facebook.Messenger.ValidateWebhook.Plug, verify_token: "supplied token"`

  Option:

  * `:verify_token` - the token set in the Messenger configuration
  """

  import Plug.Conn
  import Plug.Conn.Query

  def init(opts), do: opts

  def call(conn, opts), do: validate(conn, opts[:verify_token])

  defp validate(conn, verify_token) do
    params = decode(conn.query_string)
    case params do
      %{"hub.mode" => "subscribe",
        "hub.verify_token" => ^verify_token,
        "hub.challenge" => challenge} ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(200, challenge)
      _ ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(403, "Error")
    end
  end
end
