# index
get '/' do
  slim :index
end

# new task
get '/new' do
  slim :new
end

# get all tasks
get '/tasks' do
  @tasks = current_user.tasks
  slim :list
end

# save task
post '/new-task' do
  @task = current_user.task.create(title: params[:title],
                                    description: params[:description],
                                    user_id: session[:user_id])
  if @task.save
    flash[:success] = 'Task saved.'
    redirect '/tasks'
  else
    flash[:danger] = 'Fail to save task.'
  end
end

# edit task
get '/edit/:id' do
  @task = current_user.tasks.find_by_id(params[:id])
  unless @task.nil?
    slim :edit
  else
    flash[:warning] = 'Task dont exists.'
    redirect '/tasks'
  end
end

# update a task
post '/edit/:id' do
	@task = current_user.tasks.find_by_id(params[:id])
	@task.update(title: params[:title],
               description: params[:description])
	if @task.save
	  flash[:success] = 'Task updated.'
	  redirect '/tasks'
	else
	   slim :edit
	end
end

# delete a task
get '/delete/:id' do
  task = current_user.task.find_by_id(params[:id])
  if task.destroy
    flash[:warning] = 'Task removed.'
    redirect '/tasks'
  else
    flash[:danger] = 'Fail to remove task.'
  end
end