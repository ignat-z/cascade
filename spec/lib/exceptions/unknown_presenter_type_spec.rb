require_relative "../../spec_helper"
require_relative "../../../lib/cascade/exceptions/unknown_presenter_type"

describe Cascade::UnknownPresenterType do
  subject { Cascade::UnknownPresenterType.new }
  it "exception raisable" do
    assert_respond_to subject, :exception
  end
end
