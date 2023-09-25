defmodule BettingSystemWeb.BetslipLiveTest do
  use BettingSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import BettingSystem.BetslipsFixtures

  @create_attrs %{odds: 120.5, result_type: "some result_type", status: "some status"}
  @update_attrs %{
    odds: 456.7,
    result_type: "some updated result_type",
    status: "some updated status"
  }
  @invalid_attrs %{odds: nil, result_type: nil, status: nil}

  defp create_betslip(_) do
    betslip = betslip_fixture()
    %{betslip: betslip}
  end

  describe "Index" do
    setup [:create_betslip]

    test "lists all betslips", %{conn: conn, betslip: betslip} do
      {:ok, _index_live, html} = live(conn, Routes.betslip_index_path(conn, :index))

      assert html =~ "Listing Betslips"
      assert html =~ betslip.result_type
    end

    test "saves new betslip", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.betslip_index_path(conn, :index))

      assert index_live |> element("a", "New Betslip") |> render_click() =~
               "New Betslip"

      assert_patch(index_live, Routes.betslip_index_path(conn, :new))

      assert index_live
             |> form("#betslip-form", betslip: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#betslip-form", betslip: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.betslip_index_path(conn, :index))

      assert html =~ "Betslip created successfully"
      assert html =~ "some result_type"
    end

    test "updates betslip in listing", %{conn: conn, betslip: betslip} do
      {:ok, index_live, _html} = live(conn, Routes.betslip_index_path(conn, :index))

      assert index_live |> element("#betslip-#{betslip.id} a", "Edit") |> render_click() =~
               "Edit Betslip"

      assert_patch(index_live, Routes.betslip_index_path(conn, :edit, betslip))

      assert index_live
             |> form("#betslip-form", betslip: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#betslip-form", betslip: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.betslip_index_path(conn, :index))

      assert html =~ "Betslip updated successfully"
      assert html =~ "some updated result_type"
    end

    test "deletes betslip in listing", %{conn: conn, betslip: betslip} do
      {:ok, index_live, _html} = live(conn, Routes.betslip_index_path(conn, :index))

      assert index_live |> element("#betslip-#{betslip.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#betslip-#{betslip.id}")
    end
  end

  describe "Show" do
    setup [:create_betslip]

    test "displays betslip", %{conn: conn, betslip: betslip} do
      {:ok, _show_live, html} = live(conn, Routes.betslip_show_path(conn, :show, betslip))

      assert html =~ "Show Betslip"
      assert html =~ betslip.result_type
    end

    test "updates betslip within modal", %{conn: conn, betslip: betslip} do
      {:ok, show_live, _html} = live(conn, Routes.betslip_show_path(conn, :show, betslip))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Betslip"

      assert_patch(show_live, Routes.betslip_show_path(conn, :edit, betslip))

      assert show_live
             |> form("#betslip-form", betslip: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#betslip-form", betslip: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.betslip_show_path(conn, :show, betslip))

      assert html =~ "Betslip updated successfully"
      assert html =~ "some updated result_type"
    end
  end
end
