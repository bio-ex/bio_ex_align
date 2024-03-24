defmodule Bio.AlignTest do
  use ExUnit.Case
  doctest Bio.Align

  test "runs needleman_wunsch" do
    assert {:ok, {seq1, seq2}} =
             Bio.Align.needleman_wunsch(~c"atagc", ~c"taggg", 1.0, -1.0, -1.0, ?-)

    assert seq1 == ~c"ata-gc"
    assert seq2 == ~c"-taggg"
  end

  test "runs hirschberg" do
    assert {:ok, {seq1, seq2}} = Bio.Align.hirschberg(~c"atagc", ~c"taggg", 1.0, -1.0, -1.0, ?-)
    assert seq1 == ~c"ata-gc"
    assert seq2 == ~c"-taggg"
  end

  test "runs hirschberg uneven seqs" do
    assert {:ok, {seq1, seq2}} =
             Bio.Align.hirschberg(~c"aatacgcagaacg", ~c"taggg", 1.0, -1.0, -1.0, ?-)

    assert seq1 == ~c"aatacgcagaacg"
    assert seq2 == ~c"--ta-g--g---g"
  end

  test "returns error when sequence 1 has gap" do
    assert {:error, msg} = Bio.Align.hirschberg(~c"-atacgcagaacg", ~c"taggg", 1.0, -1.0, -1.0, ?-)
    assert msg =~ "Gap value"
  end
end
