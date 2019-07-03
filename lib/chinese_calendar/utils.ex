defmodule ChineseCalendar.Utils do
  use Bitwise

  def lunar_date_stream do
    :chinese_calendar
    |> Application.get_env(:lunar_astrology)
    |> Enum.zip(Enum.to_list(1900..2100))
    |> Stream.flat_map(&extract_date_info_from_astrology/1)
  end

  @doc """
  Get date from astrology.
  astrology: Hexadecimal number
  0x15176:
    - The first 4 bits: 
      - 1 -> leap month is big month
      - 0 -> leap month is small month
    - Middle 12 bits:
      Each bit represents one month, 1 is a big month, and 0 is a small month.
    - The last 4 bits:
      Leap month, 0 means there is not leap month in this year.
      The first 4 digits should be used with the last 4 digits.
  """
  @spec extract_date_info_from_astrology({integer(), integer()}) :: [
          {integer(), integer(), integer(), integer()}
        ]
  def extract_date_info_from_astrology({astrology, year}) do
    leap_month = astrology &&& 0x0000F

    leap_days =
      case leap_month do
        0 ->
          0

        _ ->
          case band(astrology, 0x10000) do
            0 -> 29
            _ -> 30
          end
      end

    month_digits = astrology |> band(0x0FFF0) |> bsr(4) |> Integer.digits(2)

    month_digits =
      case length(month_digits) do
        12 -> month_digits
        n -> Enum.map(1..(12 - n), fn _ -> 0 end) ++ month_digits
      end

    month_days_list =
      Enum.map(month_digits, fn
        0 -> 29
        1 -> 30
        _ -> raise "Wrong month digit"
      end)

    get_date_info(year, month_days_list, leap_month, leap_days)
    |> List.flatten()
  end

  defp get_date_info(year, month_days_list, leap_month, leap_days) do
    1..12
    |> Enum.to_list()
    |> Enum.zip(month_days_list)
    |> Enum.map(fn
      {^leap_month, month_days} ->
        get_month_days(year, leap_month, month_days, false) ++
          get_month_days(year, leap_month, leap_days, true)

      {month, month_days} ->
        get_month_days(year, month, month_days, false)
    end)
  end

  defp get_month_days(year, month, month_days, is_leap) do
    1..month_days
    |> Enum.to_list()
    |> Enum.map(fn day -> {year, month, day, is_leap} end)
  end
end
