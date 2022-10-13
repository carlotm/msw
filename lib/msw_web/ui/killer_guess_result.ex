defmodule MswWeb.UI.KillerGuessResult do
  use MswWeb, :live_component

  def render(%{bg: bg, active: active, cta: {value, label}, message: message} = assigns) do
    bg_path = Routes.static_path(MswWeb.Endpoint, "/images/#{bg}")
    bg_style = "background-image: url('#{bg_path}')"

    ~H"""
      <div class="KillerChooser-panel" style={bg_style} data-active={active}>
        <p><%= message %></p>
        <button phx-click="again" value={value} type="button">
          <%= label %>
        </button>
      </div>
    """
  end
end
