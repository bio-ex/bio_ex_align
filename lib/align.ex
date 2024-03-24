defmodule Bio.Align do
  use Rustler,
    otp_app: :bio_ex_align,
    crate: :bio_align

  def needleman_wunsch(_seq_one, _seq_two, _match_score, _mismatch_score, _indel_score, _gap_val),
    do: :erlang.nif_error(:nif_not_loaded)

  def hirschberg(_seq_one, _seq_two, _match_score, _mismatch_score, _indel_score, _gap_val),
    do: :erlang.nif_error(:nif_not_loaded)
end
