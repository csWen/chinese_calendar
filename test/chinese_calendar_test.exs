defmodule ChineseCalendarTest do
  use ExUnit.Case

  test "test solar to lunar" do
    # leap month
    assert ChineseCalendar.solar_to_lunal(2004, 4, 4) == {2004, 2, 15, true}
    assert ChineseCalendar.solar_to_lunal(1957, 10, 8) == {1957, 8, 15, true}

    # non-leap month
    assert ChineseCalendar.solar_to_lunal(1949, 10, 1) == {1949, 8, 10, false}
    assert ChineseCalendar.solar_to_lunal(2000, 1, 1) == {1999, 11, 25, false}
    assert ChineseCalendar.solar_to_lunal(1900, 1, 31) == {1900, 1, 1, false}
    assert ChineseCalendar.solar_to_lunal(2101, 1, 28) == {2100, 12, 29, false}
    assert ChineseCalendar.solar_to_lunal(1900, 1, 30) == nil
    assert ChineseCalendar.solar_to_lunal(2101, 1, 29) == nil
  end

  test "test lunar to solar" do
    # leap month
    assert ChineseCalendar.lunal_to_solar(2050, 3, 14, true) == {2050, 5, 4}
    assert ChineseCalendar.lunal_to_solar(1919, 7, 15, true) == {1919, 9, 8}

    # non-leap month
    assert ChineseCalendar.lunal_to_solar(1937, 8, 14, false) == {1937, 9, 18}
    assert ChineseCalendar.lunal_to_solar(1945, 7, 28, false) == {1945, 9, 4}
    assert ChineseCalendar.lunal_to_solar(1900, 1, 1, false) == {1900, 1, 31}
    assert ChineseCalendar.lunal_to_solar(2100, 12, 29, false) == {2101, 1, 28}
    assert ChineseCalendar.lunal_to_solar(1899, 12, 29, false) == nil
    assert ChineseCalendar.lunal_to_solar(2101, 1, 1, false) == nil
  end
end
