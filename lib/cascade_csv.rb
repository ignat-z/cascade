require "csv"

class CascadeCsv
  # Delegates oepn method to CSV with passed and alredy-defined params
  # This method opens an IO object, and wraps that with CSV.
  #
  def self.open(*args)
    options = if args.last.is_a? Hash then args.pop else Hash.new end
    CSV.open(*args << options.reverse_merge(col_sep: "\t", quote_char:  "\0"))
  end
end
