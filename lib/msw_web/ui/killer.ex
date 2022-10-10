defmodule MswWeb.UI.KillerChooser do
  use MswWeb, :live_component

  def render(%{killers: killers} = assigns) do
    killers =
      Enum.map(killers, fn killer ->
        %{
          id: killer.id,
          dom_id: "k#{killer.id}",
          bg_url: Routes.static_path(MswWeb.Endpoint, "/images/covers/#{killer.picture64}"),
          picture_url: "url('data:image/jpeg;base64,#{killer.picture64}')",
          name: killer.name
        }
      end)

    ~H"""
      <form class="KillerChooser" phx-change="guessed">
        <%= if @guess == false do %>
          <div class="KillerChooser-panel">
            <img
              src={Routes.static_path(MswWeb.Endpoint, "/images/fail.gif")}
              alt="Wrong guess"
            />
            <button phx-click="again" value="again" type="button">
              Guess again
            </button>
          </div>
        <% end %>
        <%= if @guess == true do %>
          <div class="KillerChooser-panel">
            <img
              src={Routes.static_path(MswWeb.Endpoint, "/images/success.gif")}
              alt="Correct guess"
            />
            <p>Bingo!</p>
            <button type="submit">Try another episode</button>
          </div>
        <% end %>
        <%= for killer <- killers do %>
          <label for={killer.dom_id}>
            <div
              class="KillerChooser-picture"
              style={"background-image: #{killer.picture_url}"}
            >
            </div>
            <span class="KillerChooser-text"><%= killer.name %></span>
          </label>
          <input type="hidden" value={@episode.id} name="episode" />
          <input
            id={killer.dom_id}
            name="guessed"
            value={killer.id}
            type="radio"
          />
        <% end %>
      </form>
    """
  end
end
