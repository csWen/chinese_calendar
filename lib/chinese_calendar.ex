defmodule ChineseCalendar do
  @moduledoc """
  Documentation for ChineseCalendar.
  """

  alias ChineseCalendar.Handler

  defdelegate lunal_to_solar(year, month, day, is_leap \\ false), to: Handler
  defdelegate solar_to_lunal(year, month, day), to: Handler
end
