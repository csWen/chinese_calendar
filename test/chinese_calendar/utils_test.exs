defmodule ChineseCalendar.UtilsTest do
  use ExUnit.Case

  alias ChineseCalendar.Utils

  describe "extract date info from astrology" do
    test "has no leaf month" do
      astrology = 0x04BD8
      date_info = Utils.extract_date_info_from_astrology({astrology, 1900})
      month_length_map = get_month_length_map(date_info)

      assert length(date_info) == 384
      assert Map.get(month_length_map, 1) == 29
      assert Map.get(month_length_map, 2) == 30
      assert Map.get(month_length_map, 8) == 59
    end

    test "has leaf month" do
      astrology = 0x04AE0
      date_info = Utils.extract_date_info_from_astrology({astrology, 1901})
      month_length_map = get_month_length_map(date_info)

      assert length(date_info) == 354
      assert Map.get(month_length_map, 1) == 29
      assert Map.get(month_length_map, 2) == 30
      assert Map.get(month_length_map, 12) == 29
    end
  end

  defp get_month_length_map(date_info) do
    date_info
    |> Enum.group_by(fn {_year, month, _day, _is_leap} -> month end)
    |> Map.new(fn {k, v} -> {k, length(v)} end)
  end
end
