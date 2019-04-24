require "test_helper"

describe ArticlesController do
include Devise::Test::IntegrationHelpers

  let(:article) { articles :one }
  let(:editor) { users( :editor ) }
  let(:guest) { users(:guest) }

  it "gets index" do
    get articles_url
    value(response).must_be :success?
  end

  it "gets new" do
    sign_in editor
    get new_article_url
    value(response).must_be :success?
  end

  it "creates article" do
    sign_in editor
    expect {
      post articles_url, params: { article: { category: article.category, content: article.content, title: article.title, user_id: article.user_id } }
    }.must_change "Article.count"

    must_redirect_to article_path(Article.last)
  end

  it "shows article" do
    sign_in editor
    get article_url(article)
    value(response).must_be :success?
  end

  it "gets edit" do
    sign_in editor
    get edit_article_url(article)
    value(response).must_be :success?
  end

  it "updates article" do
    sign_in editor
    patch article_url(article), params: { article: { category: article.category, content: article.content, title: article.title, user_id: article.user_id } }
    must_redirect_to article_path(article)
  end

  it "destroys article" do
    sign_in editor
    expect {
      delete article_url(article)
    }.must_change "Article.count", -1

    must_redirect_to articles_path
  end

  it "must redirect guests to new user registration" do
    get article_url(article)
    value(response).must_be :redirect?

    must_redirect_to new_user_registration_path
  end
end
