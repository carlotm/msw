defmodule MswWeb.EpisodesLive do
  use MswWeb, :live_view

  alias Msw.{Episodes, Seasons}

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        filters: [q: "", seasons: []],
        all_episodes: Episodes.all(),
        all_seasons: Seasons.all(),
        filtered: Episodes.all(),
        killer: nil,
        loading: false
      )

    {:ok, socket}
  end

  def handle_params(%{"q" => q, "seasons" => [""]}, _, socket) do
    filters = [q: q, seasons: [""]]
    send(self(), {:filter, filters})
    {:noreply, assign(socket, filters: filters, loading: true)}
  end

  def handle_params(%{"q" => q, "seasons" => seasons}, _, socket) do
    filters = [q: q, seasons: String.split(seasons, ",")]
    send(self(), {:filter, filters})
    {:noreply, assign(socket, filters: filters, loading: true)}
  end

  def handle_params(_, _, socket), do: {:noreply, socket}

  def handle_event("filter", %{"q" => "", "seasons" => ""}, socket) do
    {:noreply, push_patch(socket, to: "/")}
  end

  def handle_event("filter", %{"q" => q, "seasons" => seasons}, socket) do
    filters = [q: q, seasons: seasons]
    send(self(), {:filter, filters})
    socket = assign(socket, filters: filters, loading: true)
    {:noreply, push_patch(socket, to: "/episodes?q=#{q}&seasons=#{Enum.join(tl(seasons), ",")}")}
  end

  def handle_event("reveal", %{"value" => episode_id}, socket) do
    {:noreply, assign(socket, killer: Episodes.killer_of(episode_id))}
  end

  def handle_event("unreveal", _, socket) do
    {:noreply, assign(socket, killer: nil)}
  end

  def handle_info({:filter, filters}, socket) do
    {:noreply,
     assign(socket,
       filtered: Episodes.filter_episodes(socket.assigns.all_episodes, filters),
       loading: false
     )}
  end
end
