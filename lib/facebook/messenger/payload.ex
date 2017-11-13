defmodule Facebook.Messenger.Payload do
  @enforce_keys [:messaging_type, :recipient]
  defstruct [:message, :messaging_type, :recipient]
end
