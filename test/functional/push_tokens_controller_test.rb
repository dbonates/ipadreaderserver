require 'test_helper'

class PushTokensControllerTest < ActionController::TestCase
  setup do
    @push_token = push_tokens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:push_tokens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create push_token" do
    assert_difference('PushToken.count') do
      post :create, push_token: { token: @push_token.token }
    end

    assert_redirected_to push_token_path(assigns(:push_token))
  end

  test "should show push_token" do
    get :show, id: @push_token
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @push_token
    assert_response :success
  end

  test "should update push_token" do
    put :update, id: @push_token, push_token: { token: @push_token.token }
    assert_redirected_to push_token_path(assigns(:push_token))
  end

  test "should destroy push_token" do
    assert_difference('PushToken.count', -1) do
      delete :destroy, id: @push_token
    end

    assert_redirected_to push_tokens_path
  end
end
