defmodule Bio.AlignTest do
  use ExUnit.Case
  doctest Bio.Align

  describe "TopoGraph" do
    # NOTE: pulled data from wikipedia for verification
    test "new returns a graph thingy" do
      TopoGraph.new("GCATGCG", "GATTACA")
      |> IO.inspect()
    end

    test "new returns a graph thingy mismatch len" do
      TopoGraph.new("GCATGCG", "GATTACAA")
      |> IO.inspect()
    end
  end
end
