defmodule GenReport.Calculate do
  defp sum_values([name, total_hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    new_name = String.downcase(name)
    all_hours = calculate_all_hours(all_hours, new_name, total_hours)
    hours_per_month = calculate_hours_per_month(hours_per_month, new_name, total_hours, month)
    hours_per_year = calculate_hours_per_year(hours_per_year, new_name, total_hours, year)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp calculate_all_hours(all_hours, name, total_hours) do
    Map.put(all_hours, name, all_hours[name] + total_hours)
  end

  defp calculate_hours_per_month(hours_per_month, name, total_hours, month) do
    calc_hours_month =
      hours_per_month
      |> Map.get(name)
      |> Map.update(month, 0, fn curr -> curr + total_hours end)

    %{hours_per_month | name => calc_hours_month}
  end

  defp calculate_hours_per_year(hours_per_year, name, total_hours, year) do
    calc_hours_year =
      hours_per_year
      |> Map.get(name)
      |> Map.update(year, 0, fn curr -> curr + total_hours end)

    %{hours_per_year | name => calc_hours_year}
  end

  def build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
