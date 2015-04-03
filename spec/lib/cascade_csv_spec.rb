require_relative "../spec_helper"
require_relative "../../lib/cascade/cascade_csv"

describe Cascade::CascadeCsv do
  def described_class
    Cascade::CascadeCsv
  end

  let(:filename) { "filename.csv" }

  it "pass default col_sep and quote_char if in not setted" do
    mock(CSV).open(filename, col_sep: "\t", quote_char: "\0")
    described_class.open(filename)
  end

  it "pass specified col_sep and quote_char" do
    mock(CSV).open(filename, col_sep: "custom_sep", quote_char: "custom_quote")
    described_class.open(filename, col_sep: "custom_sep",
      quote_char: "custom_quote")
  end
end
