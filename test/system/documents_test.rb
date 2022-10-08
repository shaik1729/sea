require "application_system_test_case"

class DocumentsTest < ApplicationSystemTestCase
  setup do
    @document = documents(:one)
  end

  test "visiting the index" do
    visit documents_url
    assert_selector "h1", text: "Documents"
  end

  test "creating a Document" do
    visit documents_url
    click_on "New Document"

    fill_in "Approval status", with: @document.approval_status
    fill_in "Keywords", with: @document.keywords
    fill_in "Reviewer1", with: @document.reviewer1_id
    fill_in "Reviewer2", with: @document.reviewer2_id
    fill_in "Reviewer3", with: @document.reviewer3_id
    fill_in "Title", with: @document.title
    click_on "Create Document"

    assert_text "Document was successfully created"
    click_on "Back"
  end

  test "updating a Document" do
    visit documents_url
    click_on "Edit", match: :first

    fill_in "Approval status", with: @document.approval_status
    fill_in "Keywords", with: @document.keywords
    fill_in "Reviewer1", with: @document.reviewer1_id
    fill_in "Reviewer2", with: @document.reviewer2_id
    fill_in "Reviewer3", with: @document.reviewer3_id
    fill_in "Title", with: @document.title
    click_on "Update Document"

    assert_text "Document was successfully updated"
    click_on "Back"
  end

  test "destroying a Document" do
    visit documents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Document was successfully destroyed"
  end
end
