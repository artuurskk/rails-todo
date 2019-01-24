require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

end
