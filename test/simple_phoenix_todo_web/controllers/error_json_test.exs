defmodule SimplePhoenixTodoWeb.ErrorJSONTest do
  use SimplePhoenixTodoWeb.ConnCase, async: true

  test "renders 404" do
    assert SimplePhoenixTodoWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert SimplePhoenixTodoWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
