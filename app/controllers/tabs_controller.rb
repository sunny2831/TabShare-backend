class TabsController < ApplicationController

  def index
    @tabs = Tab.all
    render json: @tabs
  end

  # def create
  #   @tab = Tab.new(couple_id: params[:couple_id], item_id: params[:item_id])
  #   if @tab.save
  #     render json: @tab
  #   else
  #     render json: {error: "Unable to add item to tab"}, status: 400
  #   end
  # end

  def create
    @user = get_current_user
    @tab = Tab.new({
      tab_total: params[:tab_total],
      initial_amount_owed: params[:initial_amount_owed],

      description: params[:description]
      })
      owed_to = User.find(params[:owed_to_user_id])
      @tab.owed_to_user = owed_to
      owed_by = User.find(params[:owed_by_user_id])
      @tab.owed_by_user = owed_by
    if @tab.save
      render json: @tab
    else
      render json: {error: "Sorry tab was not created"}, status: 400
    end
  end

  # create_table "tabs", force: :cascade do |t|
  #   t.float "tab_total"
  #   t.float "inital_amount_owed"
  #   t.integer "owed_by_user_id"
  #   t.integer "owed_to_user_id"
  #   t.string "description"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  def show
    @tab = Tab.find(params[:id])
  end

end
