defmodule MswWeb.UI.Filters do
  use MswWeb, :live_component
  alias MswWeb.UI

  def render(assigns) do
    ~H"""
    <section class="Filters">
      <.live_component
        id="filters-form"
        module={UI.FiltersForm}
        seasons={@seasons}
        selected_seasons={@selected_seasons}
        q={@q}
      />
      <%= if @loading do %>
        <section class="Spinner"></section>
      <% end %>
    </section>
    """
  end
end
