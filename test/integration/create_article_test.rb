require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "Billy Coen", email: "billycoenaermy@outlook.com",
                        password: "password", admin: false)
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    get new_article_path
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: {title: "Tweet!", description: "This simulates a tweet...", category_ids: []} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Tweet!", response.body
  end

  test "get new article form and reject invalid article" do
    get new_article_path
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: {title: "Twee", description: "This simulates a tweet...", category_ids: []} }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end