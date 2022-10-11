defmodule MswWeb.GuessLive do
  use MswWeb, :live_view

  alias Msw.{Episodes, Killers}

  def mount(_params, _session, socket) do
    case connected?(socket) do
      true -> {:ok, assign(socket, random_episode_and_killers())}
      false -> {:ok, assign(socket, episode: nil)}
    end
  end

  defp random_episode_and_killers() do
    episode = Episodes.random()
    killer = Killers.killer_of(episode)

    [
      episode: episode,
      killers: (Killers.random(3) ++ [killer]) |> Enum.shuffle(),
      revealable: false,
      guess: nil
    ]
  end

  def handle_event("guessed", %{"guessed" => kid, "episode" => eid}, socket) do
    guessed = Killers.by_id(kid)
    {:noreply, assign(socket, :guess, "#{guessed.episode_id}" == eid)}
  end

  def handle_event("again", %{"value" => "guess"}, socket) do
    {:noreply, assign(socket, :guess, nil)}
  end

  def handle_event("again", %{"value" => "reset"}, socket) do
    {:noreply, assign(socket, random_episode_and_killers())}
  end
end
