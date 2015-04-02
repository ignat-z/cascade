require_relative "../spec_helper"
require_relative "../../lib/cascade_csv"

describe CascadeCsv do
  let(:filename) { "filename.csv" }

  it "pass default col_sep and quote_char if in not setted" do
    mock(CSV).open(filename, col_sep: "\t", quote_char: "\0")
    CascadeCsv.open(filename)
  end

  it "pass specified col_sep and quote_char" do
    mock(CSV).open(filename, col_sep: "custom_sep", quote_char: "custom_quote")
    CascadeCsv.open(filename, col_sep: "custom_sep", quote_char: "custom_quote")
  end
end
