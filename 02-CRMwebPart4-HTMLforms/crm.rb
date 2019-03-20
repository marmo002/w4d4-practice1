require './contact'
require 'sinatra'

get '/' do
  redirect to '/contacts'
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)

  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end

end

get '/contacts/new' do
  erb :new
end

get '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})

  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end

end

put '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})

  if @contact
    @contact.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      note: params[:note],
    )
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end

end

delete '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})

  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end

end

get '/contacts' do
  @contacts = Contact.all
  
  if params[:search]
    @contacts = Contact.search_me( params[:search] )
  end

  erb :contact
end

post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    note: params[:note]
  )

  redirect to '/contacts'
end

get '/about' do
  erb :about
end


after do
  ActiveRecord::Base.connection.close
end
