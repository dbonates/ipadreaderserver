require 'test_helper'

class PreviewsControllerTest < ActionController::TestCase
  setup do
    @preview = previews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:previews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preview" do
    assert_difference('Preview.count') do
      post :create, preview: { image: @preview.image, issue_id: @preview.issue_id }
    end

    assert_redirected_to preview_path(assigns(:preview))
  end

  test "should show preview" do
    get :show, id: @preview
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preview
    assert_response :success
  end

  test "should update preview" do
    put :update, id: @preview, preview: { image: @preview.image, issue_id: @preview.issue_id }
    assert_redirected_to preview_path(assigns(:preview))
  end

  test "should destroy preview" do
    assert_difference('Preview.count', -1) do
      delete :destroy, id: @preview
    end

    assert_redirected_to previews_path
  end
end
