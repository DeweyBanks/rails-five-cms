require "rails_helper"

RSpec.describe PostsHelper, "#tag_links" do
  it "returns an html link element for each tag " do
    tags = "Healthy, Food, Carrots"
    formatted_links = helper.tag_links(tags)
    expect(formatted_links).to eq "<a href=\"/tags/Healthy\">Healthy</a>, <a href=\"/tags/Food\">Food</a>, <a href=\"/tags/Carrots\">Carrots</a>"
  end
end
