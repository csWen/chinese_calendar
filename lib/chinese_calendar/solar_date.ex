defmodule ChineseCalendar.SolarDate do
  use Agent
  use Timex

  def start_link() do
    solar_start_date = Application.get_env(:chinese_calendar, :solar_start)
    Agent.start_link(fn -> solar_start_date end, name: __MODULE__)
  end

  def next_date do
    Agent.get_and_update(__MODULE__, fn date -> {date, Timex.shift(date, days: 1)} end)
  end

  def stop do
    Agent.stop(__MODULE__)
  end
end
