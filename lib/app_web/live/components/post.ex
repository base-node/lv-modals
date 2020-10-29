defmodule LivePost do
  use Phoenix.LiveComponent

  alias AppWeb.Router.Helpers, as: Routes

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="post" style="height: 200px; border: 1px solid red;">
      <span><%= live_patch "Show", to: @to %></span>
      <%= @post.title %>
    </div>
    """
  end

end
