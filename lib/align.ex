defmodule Bio.Align do
  @moduledoc """
  Provide bindings or pure elixir implementations of common alignment
  algorithms.
  """

  @doc """
  """
  def needleman_wunsch(_seq1, _seq2) do
    # The first step is to construct a graph with the sequences
    # This will be used to store the scoring
  end
end

defmodule TopoGraph do
  @moduledoc """
  A topologically ordered enumerable graph
  """
  @behaviour Access

  defstruct grid: [[]],
            # backtracking references are stored as {i,j,dir} where i and j are indices
            # of the grid, and j is the direction of the scoring reference
            backtracking: %{}

  @doc """
  We have a row and a column, and it's not particularly important which is
  which.
  First, we take the sequences, and we fill in a nil for each position.
  We'll assume that `String.graphemes` will work here.
  We don't know which is longer, so it may make sense to determine that prior.
  We can use `byte_size`, under the assumption that we're getting valid data.
  """
  def new(seq1, seq2) do
    {longer, shorter} =
      cond do
        byte_size(seq1) > byte_size(seq2) -> {seq1, seq2}
        byte_size(seq1) < byte_size(seq2) -> {seq2, seq1}
        byte_size(seq1) == byte_size(seq2) -> {seq1, seq2}
      end

    {longer_list, shorter_list} = {String.graphemes(longer), String.graphemes(shorter)}

    [row, tcol] =
      longer_list
      |> Enum.with_index()
      |> Enum.reduce([["", nil], [nil]], fn {el, idx}, [row, col] ->
        new_row = List.insert_at(row, -1, el)
        new_col = List.insert_at(col, -1, Enum.at(shorter_list, idx))
        [new_row, new_col]
      end)

    col = transpose(tcol, byte_size(longer))
    grid = List.insert_at(col, 0, row)
    tg = %__MODULE__{grid: grid}

    # first we populate the columns
    for i <- 1..byte_size(seq1) do
      IO.inspect(tg[[i, 1]])
    end
  end

  @impl Access
  def fetch(%__MODULE__{grid: grid}, index) when is_integer(index) do
    {:ok, Enum.at(grid, index)}
  end

  def fetch(%__MODULE__{grid: grid}, [i, j])
      when is_integer(i) and is_integer(j) do
    {:ok,
     Enum.at(grid, i)
     |> Enum.at(j)}
  end

  @impl Access
  def get_and_update(a, b, c) do
    IO.inspect({a, b, c}, label: "Lol, get and update")
  end

  @impl Access
  def pop(a, b) do
    IO.inspect({a, b}, label: "Lol, pop")
  end

  defp transpose(col, len) do
    for el <- col do
      nilfill =
        for _ <- 0..len do
          nil
        end

      [el] ++ nilfill
    end
  end
end

# TODO: this will make things easier, but I'll have to work it out first
# defimpl Enumerable, for: TopoGraph do
#
# end
