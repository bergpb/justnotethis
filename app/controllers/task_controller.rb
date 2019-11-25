get '/' do
  @not_completed_tasks = current_user.tasks.where(active: true).length
  @completed_tasks = current_user.tasks.where(active: false).length
  @username = current_user.username if current_user
  slim :"main/index"
end

route :get, :post, '/new' do
  method = request.env["REQUEST_METHOD"]
  if method == "GET"
    if user_signed_in?
      slim :"task/new"
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  elsif method == "POST"
    @task = Task.new(title: params[:title],
                     description: params[:description],
                     user_id: current_user.id)
    if @task.valid?
      @task.save
      flash[:success] = 'Task saved.'
      redirect '/list'
    else
      @errors = @task.errors
      slim :"task/new"
    end
  end
end

get '/list' do
  if user_signed_in?
    @tasks = current_user.tasks.order(created_at: :desc)
    @tasks.each do |task|
      task.description = task.description.gsub(/\r/, '</br>')
    end
    slim :"task/list"
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

get '/show/:id' do
  if user_signed_in?
    @task = current_user.tasks.find_by_id(params[:id])
    if @task.nil?
      flash[:warning] = "Task don't exists."
      redirect '/list'
    else
      slim :"task/show"
    end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

route :get, :post, '/edit/:id' do
  method = request.env["REQUEST_METHOD"]
  if method == "GET"
    if user_signed_in?
      @task = current_user.tasks.find_by_id(params[:id])
      unless @task.nil?
        slim :"task/edit"
      else
        flash[:warning] = "Task don't exists."
        redirect '/list'
      end
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  elsif method == "POST"
    @task = current_user.tasks.find_by_id(params[:id])
  	@task.update(title: params[:title],
                 description: params[:description],
                 active: params[:active] == "on" ? true : false)
  	if @task.valid?
  	  @task.save
  	  flash[:success] = 'Task updated.'
  	  redirect '/list'
    else
      @errors = @task.errors
  	  slim :"task/edit"
  	end
  end
end

get '/complete/:id' do
  if user_signed_in?
    @task = current_user.tasks.find_by_id(params[:id])
  	@task.update(active: false)
  	if @task.save
  	  flash[:success] = 'Task updated.'
  	  redirect '/list'
  	else
  	   flash[:danger] = 'Fail to update task.'
  	   slim :edit
  	end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

get '/delete/:id' do
  if user_signed_in?
    task = current_user.tasks.find_by_id(params[:id])
    if !task.nil?
      task.destroy
      if task.destroyed?
        flash[:success] = 'Task removed.'
        redirect '/list'
      else
        flash[:danger] = 'Fail to remove task.'
        redirect '/list'
      end
    else
      flash[:warning] = "Task don't exists."
      redirect '/list'
    end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end
