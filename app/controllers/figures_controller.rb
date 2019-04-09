class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  post '/figures' do
    @title = params[:title]
    @title_ids = params[:figure][:title_ids]
    @landmark = params[:landmark]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure = Figure.create(name: params[:figure][:name])

    if @title[:name]
      title = Title.create(name: params[:new_title])
      @figure.titles << title
    end

    if @title_ids
      @title_ids.each do |id|
        title = Title.find(id)
        @figure.titles << title
      end
    end

    if @landmark[:name]
      landmark = Landmark.create(name: params[:new_landmark])
      @figure.landmarks << landmark
    end

    if @landmark_ids
      @landmark_ids.each do |id|
        landmark = Landmark.find(id)
        @figure.landmarks << landmark
      end
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  patch '/figures/:id' do
    @title_ids = params[:figure][:title_ids]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure = Figure.find(params:id)

    if params[:new_title]
      title = Title.create(name: params[:new_title])
      @figure.titles << title
    end

    if @title_ids
      @figure.titles.clear
      @title_ids.each do |id|
        title = Title.find(id)
        @figure.titles << title
      end
    end

    if params[:new_name]
      landmark = Landmark.create(name: params[:new_name])
      @figure.landmarks << landmark
    end

    if @landmark_ids
      @figure.landmarks.clear
      @landmark_ids.each do |id|
        landmark = Landmark.find(id)
        @figure.landmarks << landmark
      end
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end
