class Upload < ActiveRecord::Base
  attr_accessible  :photo
  has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => ['application/pdf']
end
#<div class="uploadifyQueueItem" id="upload_photoTNFLLU">								<div class="cancel">									<a href="javascript:jQuery('#upload_photo').uploadifyCancel('TNFLLU')"><img border="0" src="/uploadify/cancel.png"></a>								</div>								<span class="fileName">127.Hours.2010.DVDSC... (1281.76MB)</span><span class="percentage"> - 11%</span>								<div class="uploadifyProgress">									<div class="uploadifyProgressBar" id="upload_photoTNFLLUProgressBar" style="width: 11%;"><!--Progress Bar--></div>								</div>							</div>