class MenusController < ApplicationController
  def index
    @q = Menu.ransack(params[:q])
    @menus = @q.result(:distinct => true).page(params[:page]).per(10)

    render("menus/index.html.erb")
  end

  def show
    @menu = Menu.find(params[:id])

    render("menus/show.html.erb")
  end

  def new
    @menu = Menu.new

    render("menus/new.html.erb")
  end

  def create
    @menu = Menu.new

    @menu.dish_id = params[:dish_id]
    @menu.venue_id = params[:venue_id]

    save_status = @menu.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/menus/new", "/create_menu"
        redirect_to("/menus")
      else
        redirect_back(:fallback_location => "/", :notice => "Menu created successfully.")
      end
    else
      render("menus/new.html.erb")
    end
  end

  def edit
    @menu = Menu.find(params[:id])

    render("menus/edit.html.erb")
  end

  def update
    @menu = Menu.find(params[:id])

    @menu.dish_id = params[:dish_id]
    @menu.venue_id = params[:venue_id]

    save_status = @menu.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/menus/#{@menu.id}/edit", "/update_menu"
        redirect_to("/menus/#{@menu.id}", :notice => "Menu updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Menu updated successfully.")
      end
    else
      render("menus/edit.html.erb")
    end
  end

  def destroy
    @menu = Menu.find(params[:id])

    @menu.destroy

    if URI(request.referer).path == "/menus/#{@menu.id}"
      redirect_to("/", :notice => "Menu deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Menu deleted.")
    end
  end
end
