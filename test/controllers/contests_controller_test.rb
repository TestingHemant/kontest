require 'test_helper'

class ContestsControllerTest < ActionController::TestCase
  setup do
    @contest = contests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contest" do
    assert_difference('Contest.count') do
      post :create, contest: { banner: @contest.banner, contest_type: @contest.contest_type, description: @contest.description, end_date: @contest.end_date, first_prize: @contest.first_prize, second_prize: @contest.second_prize, start_date: @contest.start_date, status: @contest.status, steps: @contest.steps, suspension_reason: @contest.suspension_reason, third_prize: @contest.third_prize, title: @contest.title }
    end

    assert_redirected_to contest_path(assigns(:contest))
  end

  test "should show contest" do
    get :show, id: @contest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contest
    assert_response :success
  end

  test "should update contest" do
    patch :update, id: @contest, contest: { banner: @contest.banner, contest_type: @contest.contest_type, description: @contest.description, end_date: @contest.end_date, first_prize: @contest.first_prize, second_prize: @contest.second_prize, start_date: @contest.start_date, status: @contest.status, steps: @contest.steps, suspension_reason: @contest.suspension_reason, third_prize: @contest.third_prize, title: @contest.title }
    assert_redirected_to contest_path(assigns(:contest))
  end

  test "should destroy contest" do
    assert_difference('Contest.count', -1) do
      delete :destroy, id: @contest
    end

    assert_redirected_to contests_path
  end
end
