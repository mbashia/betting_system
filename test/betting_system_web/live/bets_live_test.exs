defmodule BettingSystemWeb.BetsLiveTest do
  use BettingSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import BettingSystem.BetFixtures

  @create_attrs %{
    amount: 120.5,
    odds: 120.5,
    outcome: "some outcome",
    payout: 120.5,
    status: "some status"
  }
  @update_attrs %{
    amount: 456.7,
    odds: 456.7,
    outcome: "some updated outcome",
    payout: 456.7,
    status: "some updated status"
  }
  @invalid_attrs %{amount: nil, odds: nil, outcome: nil, payout: nil, status: nil}

  defp create_bets(_) do
    bets = bets_fixture()
    %{bets: bets}
  end

  describe "Index" do
    setup [:create_bets]

    test "lists all bets", %{conn: conn, bets: bets} do
      {:ok, _index_live, html} = live(conn, Routes.bets_index_path(conn, :index))

      assert html =~ "Listing Bets"
      assert html =~ bets.outcome
    end

    test "saves new bets", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bets_index_path(conn, :index))

      assert index_live |> element("a", "New Bets") |> render_click() =~
               "New Bets"

      assert_patch(index_live, Routes.bets_index_path(conn, :new))

      assert index_live
             |> form("#bets-form", bets: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bets-form", bets: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bets_index_path(conn, :index))

      assert html =~ "Bets created successfully"
      assert html =~ "some outcome"
    end

    test "updates bets in listing", %{conn: conn, bets: bets} do
      {:ok, index_live, _html} = live(conn, Routes.bets_index_path(conn, :index))

      assert index_live |> element("#bets-#{bets.id} a", "Edit") |> render_click() =~
               "Edit Bets"

      assert_patch(index_live, Routes.bets_index_path(conn, :edit, bets))

      assert index_live
             |> form("#bets-form", bets: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bets-form", bets: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bets_index_path(conn, :index))

      assert html =~ "Bets updated successfully"
      assert html =~ "some updated outcome"
    end

    test "deletes bets in listing", %{conn: conn, bets: bets} do
      {:ok, index_live, _html} = live(conn, Routes.bets_index_path(conn, :index))

      assert index_live |> element("#bets-#{bets.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bets-#{bets.id}")
    end
  end

  describe "Show" do
    setup [:create_bets]

    test "displays bets", %{conn: conn, bets: bets} do
      {:ok, _show_live, html} = live(conn, Routes.bets_show_path(conn, :show, bets))

      assert html =~ "Show Bets"
      assert html =~ bets.outcome
    end

    test "updates bets within modal", %{conn: conn, bets: bets} do
      {:ok, show_live, _html} = live(conn, Routes.bets_show_path(conn, :show, bets))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bets"

      assert_patch(show_live, Routes.bets_show_path(conn, :edit, bets))

      assert show_live
             |> form("#bets-form", bets: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bets-form", bets: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bets_show_path(conn, :show, bets))

      assert html =~ "Bets updated successfully"
      assert html =~ "some updated outcome"
    end
  end
end
