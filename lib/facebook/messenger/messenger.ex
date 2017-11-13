defmodule Facebook.Messenger do
  @moduledoc  """
  Module for interacting with the Facebook Messenger Platform
  """

  alias Facebook.GraphAPI
  alias Facebook.ResponseFormatter

  @typedoc """
  A token used to authenticate a request
  """
  @type access_token :: String.t

  @typedoc """
  The content of the message.

  The following content types are allowed:
  * `:audio`
  * `:files`
  * `:images`
  * `:text`
  * `:video`
  """
  @type content_type :: atom

  @typedoc """
  The Message Type indicates what policies and guidelines the Messenger
  Platform applies to the message.

  The three types of message types are:
    * `:standard` - allows a bot to respond to a message within 24 hours
    * `:subscription` - allows recurring messages, requires`pages_messaging_subscription` permission
    * `:sponsored` - sends an ad message to all currently open conversations the bot has open
  """
  @type messaging_type :: atom

  @typedoc """
  Message payload
  """
  @type payload :: Facebook.Messenger.Payload.t

  @typedoc """
  """
  @type response :: {:ok, Map.t} | {:error, Map.t}

  @spec send_message(payload, access_token) :: response
  def send_message(payload, access_token) do
    # TODO: encode payload -- JSON.encode works for generic Map, but fails at encoding struct without further processing
    params = [access_token: access_token]
    headers = [{"Content-Type", "application/json"}]
    ~s(/me/messages)
      |> GraphAPI.post(payload, headers, params: params)
      |> ResponseFormatter.format_response
  end

  @spec send_message(payload :: String.t, access_token) :: response
  def send_message(payload, access_token) do
    params = [access_token: access_token]
    headers = [{"Content-Type", "application/json"}]
    ~s(/me/messages)
      |> GraphAPI.post(payload, headers, params: params)
      |> ResponseFormatter.format_response
  end
end
