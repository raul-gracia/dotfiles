IEx.configure(colors: [enabled: true])
IEx.configure(colors: [eval_result: [:cyan, :bright]])

IO.puts(
  IO.ANSI.red_background() <>
    IO.ANSI.white() <> " ❄❄❄ Good Luck with Elixir ❄❄❄ " <> IO.ANSI.reset()
)

Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  colors: [
    eval_result: [:green, :bright],
    eval_error: [[:red, :bright, "Bug Bug ..!!"]],
    eval_info: [:yellow, :bright]
  ],
  default_prompt:
    [
      :white,
      "I ",
      :red,
      "❤",
      :green,
      " %prefix",
      :white,
      "|",
      :blue,
      "%counter",
      :white,
      "|",
      :red,
      "▶",
      :white,
      "▶▶",
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)
