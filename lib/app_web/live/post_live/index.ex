defmodule AppWeb.PostLive.Index do
  use AppWeb, :live_view

  alias App.Posts
  alias App.Posts.Post

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(to: Routes.post_index_path(socket, :index))
      |> assign(page: 1, per_page: 5)
      |> fetch(), temporary_assigns: [post: nil, posts: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Posts.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  defp list_posts do
    Posts.list_posts()
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, posts: Posts.list_posts(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
end
