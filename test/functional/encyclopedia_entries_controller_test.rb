require 'test_helper'

class EncyclopediaEntriesControllerTest < ActionController::TestCase
  setup do
    @encyclopedia_entry = encyclopedia_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:encyclopedia_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create encyclopedia_entry" do
    assert_difference('EncyclopediaEntry.count') do
      post :create, encyclopedia_entry: { attack: @encyclopedia_entry.attack, defense: @encyclopedia_entry.defense, description: @encyclopedia_entry.description, magic: @encyclopedia_entry.magic, puzzle_id: @encyclopedia_entry.puzzle_id, speed: @encyclopedia_entry.speed }
    end

    assert_redirected_to encyclopedia_entry_path(assigns(:encyclopedia_entry))
  end

  test "should show encyclopedia_entry" do
    get :show, id: @encyclopedia_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @encyclopedia_entry
    assert_response :success
  end

  test "should update encyclopedia_entry" do
    put :update, id: @encyclopedia_entry, encyclopedia_entry: { attack: @encyclopedia_entry.attack, defense: @encyclopedia_entry.defense, description: @encyclopedia_entry.description, magic: @encyclopedia_entry.magic, puzzle_id: @encyclopedia_entry.puzzle_id, speed: @encyclopedia_entry.speed }
    assert_redirected_to encyclopedia_entry_path(assigns(:encyclopedia_entry))
  end

  test "should destroy encyclopedia_entry" do
    assert_difference('EncyclopediaEntry.count', -1) do
      delete :destroy, id: @encyclopedia_entry
    end

    assert_redirected_to encyclopedia_entries_path
  end
end
