defmodule MswWeb.UI.EpisodeCard do
  use MswWeb, :live_component

  def render(%{episode: episode, killer: killer} = assigns) do
    episode_id = "s#{episode.season.number}e#{episode.number}"
    bg_url = Routes.static_path(MswWeb.Endpoint, "/images/covers/#{episode.poster}")
    bg_style = "background-image: url(#{bg_url});"
    killer_revealed = killer != nil and episode.id == killer.episode_id

    episode_class =
      case killer_revealed do
        true -> "Episode Episode-reveal"
        false -> "Episode"
      end

    ~H"""
    <article id={episode_id} class={episode_class}>
      <div class="Episode-front">
        <%= if @episode.poster != "" do %>
          <div class="Episode-poster" style={bg_style}></div>
        <% end %>
        <header>
          <h2 class="Episode-title"><%= @episode.title %></h2>
        </header>
        <section>
          <input
            id={"#{episode_id}-plot"}
            type="checkbox"
            title="Toggle plot visibility"
            class="Episode-plot_toggler"
          />
          <label for={"#{episode_id}-plot"} class="Episode-plot_label">Plot</label>
          <p class="Episode-plot"><%= @episode.plot %></p>
        </section>
        <footer class="Episode-foot">
          <p>Season <%= @episode.season.number %></p>
          <p>Episode <%= @episode.number %></p>
        </footer>
        <aside class="Episode-cta">
          <button phx-click="reveal" value={@episode.id}>Reveal Killer</button>
        </aside>
      </div>
      <div class="Episode-back Episode-killer">
        <%= if killer_revealed do %>
          <img
            src={"data:image/jpeg;base64,#{@killer.picture64}"}
            title={@killer.name}
            alt={@killer.name}
            class="Episode-killer_image"
          />
          <p class="Episode-killer_name"><%= @killer.name %></p>
          <button class="Episode-killer_unreveal" phx-click="unreveal">hide</button>
        <% end %>
      </div>
    </article>
    """
  end
end
