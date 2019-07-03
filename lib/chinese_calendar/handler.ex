defmodule ChineseCalendar.Handler do
  alias ChineseCalendar.{Utils, SolarDate}

  SolarDate.start_link

  Utils.lunar_date_stream()
  |> Stream.map(fn {lyear, lmonth, lday, is_leap} ->
    %{year: syear, month: smonth, day: sday} = SolarDate.next_date()

    defp l_s(unquote(lyear), unquote(lmonth), unquote(lday), unquote(is_leap)),
      do: {unquote(syear), unquote(smonth), unquote(sday)}

    defp s_l(unquote(syear), unquote(smonth), unquote(sday)),
      do: {unquote(lyear), unquote(lmonth), unquote(lday), unquote(is_leap)}
  end)
  |> Enum.to_list()

  SolarDate.stop

  defp l_s(_, _, _, _), do: nil
  defp s_l(_, _, _), do: nil

  def lunal_to_solar(year, month, day, is_leap),
    do: l_s(year, month, day, is_leap)

  def solar_to_lunal(year, month, day),
    do: s_l(year, month, day)
end
