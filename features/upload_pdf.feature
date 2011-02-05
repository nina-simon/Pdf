Feature: Uploading Pdf
  In order to save my Pdf file
  As a guest
  I want to upload my Pdf file
@javascript
  Scenario: Upload Pdf
    Given I am on the home page
	And I have not uploaded any pdf yet
    When I attach the file "somefile.pdf" to "upload_photo"
    Then I should have 1 pdf uploaded
	And I should see "Your Pdf has been uploaded successfully"
	And I should see "thumb_somefile_pdf" within "content_thumbnails"
@javascript
  Scenario: Thumbnail view
	Given I've an uploaded pdf named "somefile.pdf"
	Then I should see "thumb_somefile_pdf" within "content_thumbnails"
@javascript
  Scenario: Thumbnail clickable view
	Given I've an uploaded pdf named "somefile.pdf"
	When I click on "thumb_somefile_pdf"
	Then I should see "somefile.pdf" view page
@javascript
  Scenario: files other then pdf shouldn't be uploadable
	Given I am on the home page
	And I have not uploaded any pdf yet
    When I attach the file "somefile.notpdf" to "file"
	And I click on "Upload pdf"
	Then I should see "Only Pdf files are allowed"
	And the file "somefile.notpdf" should not be uploaded
	