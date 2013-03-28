class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, except: [:index, :show]
  load_and_authorize_resource except: [:show, :edit]
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end


  def show
    @user = User.find(params[:id])
    @entries = @user.entries.all

    # high charts
    other =             @entries.where(category: "other").count / @entries.count.to_f * 100
    just_feeling_off =  @entries.where(category: "just feeling off").count / @entries.count.to_f * 100
    alcohol_drugs =     @entries.where(category: "alcohol/drugs").count / @entries.count.to_f * 100
    body_health =       @entries.where(category: "body/health").count / @entries.count.to_f * 100
    dreams_sleep =      @entries.where(category: "dreams/sleep").count / @entries.count.to_f * 100
    family_friends =    @entries.where(category: "family/friends").count / @entries.count.to_f * 100
    sex_relationships = @entries.where(category: "sex/relationships").count / @entries.count.to_f * 100
    work_school =       @entries.where(category: "work/school").count / @entries.count.to_f * 100

    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 0, 100, 0]})
      series = {
        :type=> 'pie',
        :name=> 'Categories',
        :data=> [
                 ['other',             other],
                 ['just feeling off',  just_feeling_off],
                 ['alcohol/drugs',     alcohol_drugs],
                 ['body/health',       body_health],
                 ['dreams/sleep',      dreams_sleep],
                 ['family/friends',    family_friends],
                 ['sex/relationships', sex_relationships],
                 ['work/school',       work_school]
                ]
      }
      f.series(series)
      f.options[:title][:text] = "Issues you journal most about"
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})
      f.plot_options(:pie=>{
                       :allowPointSelect=>true,
                       :cursor=>"pointer" ,
                       :dataLabels=>{
                         :enabled=>true,
                         :color=>"black",
                         :style=>{
                           :font=>"13px Helvetica Neue, Helvetica, Arial"
                         }
                       }
                     })
    end

  end


end
