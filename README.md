# ChineseCalendar

**Convert Solar Calendar and Lunar Calendar.**  
Range:  
solar: 1900-01-31 ~ 2101-01-28  
lunal: 1900-01-01 ~ 2100-12-29

```elixir
ChineseCalendar.lunal_to_solar(1949, 8, 10, false) # -> {1949, 10, 1}
ChineseCalendar.solar_to_lunal(1949, 10, 1) # -> {1949, 8, 10, false}
```