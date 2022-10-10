defmodule MswWeb.EpisodesLive do
  use MswWeb, :live_view

  alias Msw.Episodes

  def mount(_params, _session, socket) do
    all_episodes = Episodes.all()

    socket =
      assign(socket,
        all_episodes: all_episodes,
        filtered: all_episodes,
        killer: nil,
        loading: false
      )

    {:ok, socket}
  end

  def handle_event("reveal", %{"value" => episode_id}, socket) do
    {:noreply, assign(socket, killer: Episodes.killer_of(episode_id))}
  end

  def handle_event("unreveal", _, socket) do
    {:noreply, assign(socket, killer: nil)}
  end
end
