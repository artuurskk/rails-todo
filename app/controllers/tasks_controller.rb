class TasksController < ApplicationController
  helper_method :current_user
  before_action :set_task, only: [:show, :edit, :update, :destroy, :check]

  # GET /tasks
  # GET /tasks.json
  def index
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
      @tasks = Task.all
    else
      @current_user = nil
      @tasks = nil
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.new(task_params)
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    #@task = Task.new(task_params.merge(user_id: current_user.id))
    @task = current_user.tasks.new(task_params)
    @task.name = params[:task][:name]
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_url, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to root_url, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
        @tasks = current_user.tasks.all
        ActionCable.server.broadcast 'tasks',
                                     html: render_to_string('index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Task was successfully destroyed.' }
      format.js
      format.json { head :no_content }
      @tasks = current_user.tasks.all
      ActionCable.server.broadcast 'tasks',
                                   html: render_to_string('index', layout: false)
    end
  end

  def check
    @task.update_column(:status, 1)
    respond_to do |format|
          format.html { redirect_to root_url, notice: 'Task was marked as done.' }
          format.js
          format.json { head :no_content }
          @tasks = current_user.tasks.all
          ActionCable.server.broadcast 'tasks',
                                       html: render_to_string('index', layout: false)
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.permit(:name, :status, :user_id)
    end
end
