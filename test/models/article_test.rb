require "test_helper"

describe Article do
  let(:article) { articles(:one) }
  let(:invalid_article) { articles(:invalid) }

  it "must be valid" do
    value(article).must_be :valid?
  end

  it "must be not accept an article without valid parameters" do
    value(invalid_article).must_be :invalid?
  end

  it "must have a title" do
    article.title.must_be_instance_of String
  end

  it "must have a content" do
    article.content.must_be_instance_of String
  end

  it "must have a foreign key" do
    article.user_id.must_be_instance_of Integer
  end
end
