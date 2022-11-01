defmodule GenReport do
  # Dez pessoas fizeram freelas para uma empresa X durante cinco anos
  # e o histórico com todos os dados de cada uma dessas pessoas
  # foram passadas para um arquivo CSV

  # CSV -> nome, quantidade de horas, dia, mês e ano

  # quantidade de horas -> varia de 1 a 8 hrs
  # dia -> varia de 1 a 30 (mesmo para o mês de fevereiro e sem considerar anos bissextos)
  # ano -> varia de 2016 a 2020
  alias GenReport.Parser
  alias GenReport.Calculate

  # Nomes contidos na lista
  @available_names [
    "cleiton",
    "daniele",
    "danilo",
    "diego",
    "giuliano",
    "jakeliny",
    "joseph",
    "mayk",
    "rafael",
    "vinicius"
  ]

  @available_months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  def build(), do: {:error, "Insira o nome de um arquivo"}

  # GenReport.build("gen_report.csv")
  def build(filename) do
    # result =
    filename
    # ["Giuliano", 3, "15", "8", "2020"]
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> Calculate.sum_values(line, report) end)

    # {:ok, result}
  end

  defp report_acc do
    Calculate.build_report(
      report_names_acc(),
      get_names_per_acc(report_months_acc()),
      get_names_per_acc(report_years_acc())
    )
  end

  defp report_names_acc, do: Enum.into(@available_names, %{}, &{&1, 0})

  defp report_months_acc do
    @available_months
    |> Enum.into(%{}, &{&1, 0})
  end

  defp report_years_acc, do: Enum.into(2016..2020, %{}, &{&1, 0})

  defp get_names_per_acc(acc) do
    @available_names
    |> Enum.into(%{}, &{&1, acc})
  end
end
