defmodule MswWeb.UI.KillerChooser do
  use MswWeb, :live_component
  alias MswWeb.UI

  def render(%{killers: killers} = assigns) do
    ~H"""
      <form class="KillerChooser" phx-change="guessed">
        <.live_component
          module={UI.KillerGuessResult}
          id="guess-failed"
          bg="fail.gif"
          active={@guess == false}
          cta={{"guess", "Guess again"}}
          message="Nope"
        />
        <.live_component
          module={UI.KillerGuessResult}
          id="guess-success"
          bg="success.gif"
          active={@guess == true}
          cta={{"reset", "Try another episode"}}
          message="Bingo!"
        />
        <%= for killer <- killers do %>
          <.live_component
            module={UI.KillerChoice}
            id={killer.id}
            killer={killer}
            episode={@episode}
          />
        <% end %>
      </form>
    """
  end
end
