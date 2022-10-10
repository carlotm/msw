defmodule MswWeb.UI.Filters do
  use MswWeb, :live_component

  def render(%{seasons: _seasons} = assigns) do
    ~H"""
    <section class="Filters">
      <form id="Filters-form" phx-change="filter">
        <div class="Filters-filter">
          <label for="q">Filter episodes by title</label>
          <input
            id="q"
            name="q"
            type="text"
            placeholder="Word..."
            value={@q}
            autocomplete="off"
            phx-debounce="200" />
        </div>
        <div class="Filters-filter Filters-filter--checks">
          <h3>Filter episodes by season</h3>
          <input type="hidden" value="" name="seasons[]">
          <%= for s <- @seasons do %>
            <input
              type="checkbox"
              name="seasons[]"
              id={"s#{s.number}"}
              value={s.number}
              checked={"#{s.number}" in @selected_seasons}
            />
            <label for={"s#{s.number}"}><%= s.number %></label>
          <% end %>
        </div>
      </form>
      <%= if @loading do %>
        <section class="Spinner"></section>
      <% end %>
    </section>
    """
  end
end
