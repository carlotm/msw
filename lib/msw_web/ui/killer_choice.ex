defmodule MswWeb.UI.KillerChoice do
  use MswWeb, :live_component

  def render(%{killer: killer, episode: episode} = assigns) do
    dom_id = "k#{killer.id}"
    picture_url = "url('data:image/jpeg;base64,#{killer.picture64}')"

    ~H"""
      <label for={dom_id}>
        <div
          class="KillerChooser-picture"
          style={"background-image: #{picture_url}"}
        />
        <span class="KillerChooser-text"><%= killer.name %></span>
        <input type="hidden" value={episode.id} name="episode" />
        <input
          id={dom_id}
          name="guessed"
          value={killer.id}
          type="radio"
        />
      </label>
    """
  end
end
