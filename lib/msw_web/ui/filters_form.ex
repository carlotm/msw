defmodule MswWeb.UI.FiltersForm do
  use MswWeb, :live_component

  def render(%{seasons: seasons, selected_seasons: selected_seasons, q: q} = assigns) do
    ~H"""
    <form id="Filters-form" phx-change="filter">
      <div class="Filter">
        <label class="Filter-name" for="q">
          Filter episodes by title
        </label>
        <input
          id="q"
          name="q"
          type="text"
          placeholder="Word..."
          value={q}
          autocomplete="off"
          phx-debounce="200" />
      </div>
      <div class="Filter">
        <h3 class="Filter-name">Filter episodes by season</h3>
        <input type="hidden" value="" name="seasons[]">
        <%= for s <- seasons do %>
          <input
            type="checkbox"
            name="seasons[]"
            id={"s#{s.number}"}
            value={s.number}
            checked={"#{s.number}" in selected_seasons}
          />
          <label for={"s#{s.number}"}><%= s.number %></label>
        <% end %>
      </div>
    </form>
    """
  end
end
