class UploadsController < ApplicationController
  def index
    @uploads = Upload.all
  end
  def create
    newparams = coerce(params)
    @upload = Upload.new(newparams[:upload])
    if @upload.save
      render :json => { :status=>true, :result => 'PDF is uploaded successfully!', :file_name => @upload.photo_file_name, :id=>@upload.id }
    else
      render :json => { :status=>false, :result => 'Only PDF file are allowed for upload.', :file_name => @upload.photo_file_name } 
    end
  end

  def show
    send_file(Upload.find(params[:id]).photo.path)
  end
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to(uploads_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def coerce(params)
    if params[:upload].nil?
      h = Hash.new
      h[:upload] = Hash.new
      h[:upload][:photo] = params[:Filedata]
      h[:upload][:photo].content_type = MIME::Types.type_for(h[:upload][:photo].original_filename).to_s
      h
    else
      params
    end
  end
  
end
