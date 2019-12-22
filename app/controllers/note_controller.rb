route :get, :post, '/new' do
  method = request.env["REQUEST_METHOD"]
  if method == "GET"
    if user_signed_in?
      slim :"note/new"
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  elsif method == "POST"
    if user_signed_in?
      note = Note.new(title: params[:title],
                       description: params[:description],
                       user_id: current_user.id)
      if note.valid?
        note.save
        flash[:success] = 'Note saved.'
        redirect '/list'
      else
        slim :"note/new", locals: {errors: user.errors}
      end
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  end
end

get '/list' do
  search_for = nil
  if user_signed_in?
    pagy, notes = pagy(current_user.notes.order(created_at: :desc))
    notes.each do |note|
      note.description = note.description.gsub(/\r/, '</br>')
    end
    slim :"note/list", locals: {
      notes: notes,
      pagy: pagy,
      search_for: search_for
    }
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

route :get, :post, '/search' do
  method = request.env['REQUEST_METHOD']
  case ActiveRecord::Base.connection.adapter_name
  when 'PostgreSQL'
    like = 'title ILIKE ?'
  else
    like = 'title LIKE ?'
  end
  if method == 'GET'
    flash[:warning] = 'Nothing to search.'
    redirect '/list'
  elsif method == 'POST'
    if user_signed_in?
      search_for = params[:search]
      notes = current_user.notes.where(like, "%#{search_for}%").order(created_at: :desc)
      notes.each do |note|
        note.description = note.description.gsub(/\r/, '</br>')
      end
      slim :"note/list", locals: {notes: notes, search_for: search_for}
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  end
end

get '/show/:id' do
  if user_signed_in?
    note = current_user.notes.find_by_id(params[:id])
    if !note.nil?
      slim :"note/show", locals: {note: note}
    else
      flash[:warning] = "Note don't exists."
      redirect '/list'
    end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

route :get, :post, '/edit/:id' do
  method = request.env['REQUEST_METHOD']
  if method == 'GET'
    if user_signed_in?
      note = current_user.notes.find_by_id(params[:id])
      if !note.nil?
        slim :"note/edit", locals: {note: note}
      else
        flash[:warning] = "Note don't exists."
        redirect '/list'
      end
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  elsif method == 'POST'
    if user_signed_in?
      note = current_user.notes.find_by_id(params[:id])
      if !note.nil?
        note.update(title: params[:title],
                     description: params[:description],
                     active: params[:active] == "on" ? true : false)
        if note.valid?
          note.save
          flash[:success] = 'Note updated.'
          redirect '/list'
        else
          slim :"note/edit", locals: {errors: note.errors}
        end
      else
        flash[:warning] = "Note don't exists."
        redirect '/list'
      end
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  end
end

get '/complete/:id' do
  if user_signed_in?
    note = current_user.notes.find_by_id(params[:id])
    if !note.nil?
      note.update(active: false)
      if !note.save
        flash[:danger] = 'Fail to update note.'
        slim :edit, locals: {note: note}
      else
        flash[:success] = 'Note marked with complete.'
        redirect '/list'
      end
    else
      flash[:warning] = "Note don't exists."
      redirect '/list'
    end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

get '/delete/:id' do
  if user_signed_in?
    note = current_user.notes.find_by_id(params[:id])
    unless note.nil?
      note.destroy
      if note.destroyed?
        flash[:success] = 'Note removed.'
      else
        flash[:danger] = 'Fail to remove note.'
      end
    else
      flash[:warning] = "Note don't exists."
    end
    redirect '/list'
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

include Pagy::Frontend
include Pagy::Backend
