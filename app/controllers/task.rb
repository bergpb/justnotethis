get '/new' do
  if user_signed_in?
    slim :new
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

get '/tasks' do
  if user_signed_in?
    @tasks = current_user.tasks.order(created_at: :desc)
    slim :list
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

get '/show/:id' do
  if user_signed_in?
    @task = current_user.tasks.find_by_id(params[:id])
    slim :show
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

post '/new' do
  if user_signed_in?
    task = Task.new(title: params[:title],
                    description: params[:description],
                    user_id: current_user.id)
    if task.save
      flash[:success] = 'Task saved.'
      redirect '/tasks'
    else
      flash[:danger] = 'Fail to save task.'
    end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

get '/edit/:id' do
  if user_signed_in?
    @task = current_user.tasks.find_by_id(params[:id])
    unless @task.nil?
      slim :edit
    else
      flash[:warning] = 'Task dont exists.'
      redirect '/tasks'
    end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

post '/edit/:id' do
	@task = current_user.tasks.find_by_id(params[:id])
	@task.update(title: params[:title],
               description: params[:description],
               active: params[:active] == "on" ? true : false)
	if @task.save
	  flash[:success] = 'Task updated.'
	  redirect '/tasks'
	else
	   slim :edit
	end
end

get '/complete/:id' do
  if user_signed_in?
    @task = current_user.tasks.find_by_id(params[:id])
  	@task.update(active: false)
  	if @task.save
  	  flash[:success] = 'Task updated.'
  	  redirect '/tasks'
  	else
  	   flash[:success] = 'Fail to mark task with complete.'
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
    unless task.nil?
      task.destroy
      if task.destroyed?
        flash[:warning] = 'Task removed.'
        redirect '/tasks'
      else
        flash[:warning] = 'Fail to remove task.'
        redirect '/tasks'
      end
    else
      flash[:danger] = 'Task dont exists.'
      redirect '/tasks'
    end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end
