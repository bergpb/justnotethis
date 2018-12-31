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
  @tasks = Task.order(id: :desc)
  slim :tasks
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
                      description: params[:description])
  flash[:notice] = 'Task saved.'
  redirect '/tasks'
end

# update a task
post '/edit/:id' do
	@task = Task.find(params[:id])
	@task.update(title: params[:title],
               description: params[:description])
	if @task.save
	  flash[:notice] = 'Task updated.'
	  redirect '/tasks'
	else
	   slim :edit
	end
end

# delete a task
get '/delete/:id' do
  @task = Task.find(params[:id])
  if @task.destroy
    flash[:notice] = 'Task removed.'
    redirect '/tasks'
  else
    flash[:notice] = 'Fail to remove task.'
  end
end