# frozen_string_literal: true

route :get, :post, '/new' do
  method = request.env['REQUEST_METHOD']
  if method == 'GET'
    if user_signed_in?
      slim :"note/new", locals: { errors: nil }
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  elsif method == 'POST'
    if user_signed_in?
      note = Note.new(title: params[:title],
                      description: params[:description],
                      user_id: current_user.id)
      if note.valid?
        note.save
        flash[:success] = 'Note saved.'
        redirect '/list'
      else
        slim :"note/new", locals: { note: note, errors: note.errors }
      end
    else
      flash[:warning] = 'Please login.'
      redirect '/login'
    end
  end
end

get '/list' do
  if user_signed_in?
    begin
      puts params[:type]
      if params[:type] == 'complete'
        pagy, notes = pagy(current_user.notes.where(active: false).order(created_at: :desc))
      else
        pagy, notes = pagy(current_user.notes.where(active: true).order(created_at: :desc))
      end
      if pagy
        slim :"note/list", locals: {
          notes: notes,
          pagy: pagy,
          search_for: nil
        }
      end
    rescue Pagy::OverflowError => e
      flash.now[:info] = 'Page not found! Showing last page.'
      pagy, notes = pagy(current_user.notes.order(created_at: :desc),
                         page: e.pagy.last)
      slim :"note/list", locals: {
        notes: notes,
        pagy: pagy,
        search_for: nil
      }
    end
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

get '/search' do
  like = check_database_type
  if user_signed_in?
    search_for = params[:search]
    notes = current_user.notes.where("title #{like} ?", "%#{search_for}%").order(created_at: :desc)
    slim :"note/list", locals: { notes: notes, search_for: search_for }
  else
    flash[:warning] = 'Please login.'
    redirect '/login'
  end
end

get '/show/:id' do
  if user_signed_in?
    note = current_user.notes.find_by_id(params[:id])
    if !note.nil?
      slim :"note/show", locals: { note: note }
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
        slim :"note/edit", locals: { note: note, errors: nil }
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
                    active: params[:active] == 'on')
        if note.valid?
          note.save
          flash[:success] = 'Note updated.'
          redirect '/list'
        else
          slim :"note/edit", locals: { note: note, errors: note.errors }
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
        slim :edit, locals: { note: note }
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
    if !note.nil?
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
