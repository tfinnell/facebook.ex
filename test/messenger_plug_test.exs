defmodule FacebookTest.Messenger.Plug do
  use ExUnit.Case
  use Plug.Test

  alias Facebook.Messenger

  describe "Messenger.Plug" do
    test "responds with challenge when token verified" do
      token = generate_token()
      challenge_response = "verified"
      params = fb_verification_params(token, challenge_response)
      conn = conn(:get, "/webhook?#{params}", nil)
             |> Messenger.Plug.call([verify_token: token])

      assert 200 = conn.status
      assert ^challenge_response = conn.resp_body
    end

    test "responds with forbidden error if tokens don't match" do
      token = generate_token()
      invalid_token = generate_token()
      challenge_response = "verified"
      params = fb_verification_params(invalid_token, challenge_response)
      conn = conn(:get, "/webhook?#{params}", nil)
             |> Messenger.Plug.call([verify_token: token])

      assert 403 = conn.status
      assert "Error" = conn.resp_body
    end

    test "responds with forbidden error with wrong params" do
      token = generate_token()
      conn = conn(:get, "/webhook?fetch=user_id", nil)
             |> Messenger.Plug.call([verify_token: token])

      assert 403 = conn.status
      assert "Error" = conn.resp_body
    end

    test "responds with forbidden error with no params" do
      token = generate_token()
      conn = conn(:get, "/webhook", nil)
             |> Messenger.Plug.call([verify_token: token])

      assert 403 = conn.status
      assert "Error" = conn.resp_body
    end
  end

  defp generate_token do
    time = DateTime.utc_now |> DateTime.to_string
    :crypto.hash(:sha, time)
    |> Base.encode16
  end

  defp fb_verification_params(token, challenge_response) do
    %{"hub.mode" => "subscribe",
      "hub.verify_token" => token,
      "hub.challenge" => challenge_response}
      |> Plug.Conn.Query.encode
  end
end
