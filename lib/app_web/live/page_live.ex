defmodule AppWeb.PageLive do
  use AppWeb, :live_view

  alias App.Posts
  alias App.Posts.Post

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(to: Routes.page_path(socket, :index))
     |> assign(page: 1, per_page: 10)
     |> fetch(), temporary_assigns: [post: nil, posts: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    assign(socket, :page_title, "Index")
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, posts: Posts.list_posts(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end

end
