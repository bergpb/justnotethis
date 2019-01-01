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
  @tasks = User.find(session[:user_id]).tasks
  slim :list
end

# edit task
get '/edit/:id' do
  @task = Task.find(params[:id])
  unless @task.nil? # if return false do this
    slim :edit
  else
    redirect '/tasks'
  end
end

# save task
post '/new-task' do
  @task = Task.create(title: params[:title],
                      description: params[:description],
                      user_id: session[:user_id])
  if @task.save
    flash[:success] = 'Task saved.'
    redirect '/tasks'
  else
    flash[:danger] = 'Fail to save task.'
  end
end

# update a task
post '/edit/:id' do
	@task = Task.find(params[:id])
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
  task = Task.find(params[:id])
  if task.destroy
    flash[:warning] = 'Task removed.'
    redirect '/tasks'
  else
    flash[:danger] = 'Fail to remove task.'
  end
end