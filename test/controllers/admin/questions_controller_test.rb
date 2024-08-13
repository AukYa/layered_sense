require "test_helper"

class Admin::QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_questions_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_questions_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_questions_edit_url
    assert_response :success
  end
end
