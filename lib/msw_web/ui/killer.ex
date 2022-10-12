defmodule MswWeb.UI.KillerChooser do
  use MswWeb, :live_component

  def render(%{killers: killers} = assigns) do
    killers =
      Enum.map(killers, fn killer ->
        %{
          id: killer.id,
          dom_id: "k#{killer.id}",
          picture_url: "url('data:image/jpeg;base64,#{killer.picture64}')",
          name: killer.name
        }
      end)

    fail_image_path = Routes.static_path(MswWeb.Endpoint, "/images/fail.gif")
    success_image_path = Routes.static_path(MswWeb.Endpoint, "/images/success.gif")

    panel_bg = %{
      fail: [style: "background-image: url('#{fail_image_path}')"],
      success: [style: "background-image: url('#{success_image_path}')"]
    }

    ~H"""
      <form class="KillerChooser" phx-change="guessed">
        <div class="KillerChooser-panel" {panel_bg.fail} data-active={@guess == false}>
          <button phx-click="again" value="guess" type="button">
            Guess again
          </button>
        </div>
        <div class="KillerChooser-panel" {panel_bg.success} data-active={@guess == true}>
          <p>Bingo!</p>
          <button phx-click="again" value="reset" type="button">
            Try another episode
          </button>
        </div>
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
