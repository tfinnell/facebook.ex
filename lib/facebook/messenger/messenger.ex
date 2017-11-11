defmodule Facebook.Messenger do
  @moduledoc  """
  Module for interacting with the Facebook Messenger Platform
  """

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
end
