defmodule MswWeb.GuessLive do
  use MswWeb, :live_view

  alias Msw.{Episodes, Killers}

  def mount(_params, _session, socket) do
    episode = Episodes.random()
    killer = Killers.killer_of(episode)

    socket =
      assign(socket,
        episode: episode,
        killers: (Killers.random(3) ++ [killer]) |> Enum.shuffle(),
        revealable: false,
        guess: nil
      )

    {:ok, socket}
  end

  def handle_event("guessed", %{"guessed" => kid, "episode" => eid}, socket) do
    guessed = Killers.by_id(kid)
    {:noreply, assign(socket, :guess, "#{guessed.episode_id}" == eid)}
  end

  def handle_event("again", _params, socket) do
    {:noreply, assign(socket, :guess, nil)}
  end
end
