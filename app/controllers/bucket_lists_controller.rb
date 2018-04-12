class BucketListsController < ApplicationController
  def index
    @q = BucketList.ransack(params[:q])
    @bucket_lists = @q.result(:distinct => true).page(params[:page]).per(10)

    render("bucket_lists/index.html.erb")
  end

  def show
    @bucket_list = BucketList.find(params[:id])

    render("bucket_lists/show.html.erb")
  end

  def new
    @bucket_list = BucketList.new

    render("bucket_lists/new.html.erb")
  end

  def create
    @bucket_list = BucketList.new


    save_status = @bucket_list.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/bucket_lists/new", "/create_bucket_list"
        redirect_to("/bucket_lists")
      else
        redirect_back(:fallback_location => "/", :notice => "Bucket list created successfully.")
      end
    else
      render("bucket_lists/new.html.erb")
    end
  end

  def edit
    @bucket_list = BucketList.find(params[:id])

    render("bucket_lists/edit.html.erb")
  end

  def update
    @bucket_list = BucketList.find(params[:id])


    save_status = @bucket_list.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/bucket_lists/#{@bucket_list.id}/edit", "/update_bucket_list"
        redirect_to("/bucket_lists/#{@bucket_list.id}", :notice => "Bucket list updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Bucket list updated successfully.")
      end
    else
      render("bucket_lists/edit.html.erb")
    end
  end

  def destroy
    @bucket_list = BucketList.find(params[:id])

    @bucket_list.destroy

    if URI(request.referer).path == "/bucket_lists/#{@bucket_list.id}"
      redirect_to("/", :notice => "Bucket list deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Bucket list deleted.")
    end
  end
end
