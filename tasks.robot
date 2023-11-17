*** Settings ***
Documentation       Creates PDF invitations based on Excel data.

Library             RPA.Archive
Library             RPA.Excel.Files
Library             RPA.FileSystem
Library             RPA.PDF


*** Variables ***
${EXCEL_FILE_PATH}=                 ${CURDIR}${/}devdata${/}Data.xlsx
${PDF_TEMP_OUTPUT_DIRECTORY}=       ${CURDIR}${/}temp
${PDF_TEMPLATE_PATH}=               ${CURDIR}${/}devdata${/}invite.template


*** Tasks ***
Create PDF invitations
    Set up directories
    ${invitations}=    Collect invitations from the Excel file
    FOR    ${invitation}    IN    @{invitations}
        Run Keyword And Continue On Failure
        ...    Create PDF file for invitation
        ...    ${invitation}
    END
    ${zip_file_path}=    Create ZIP package from PDF files
    Log    Archive with the PDF invitations: ${zip_file_path}    level=WARN
    [Teardown]    Cleanup temporary PDF directory


*** Keywords ***
Set up directories
    Create Directory    ${PDF_TEMP_OUTPUT_DIRECTORY}
    Create Directory    ${OUTPUT_DIR}

Collect invitations from the Excel file
    Open Workbook    ${EXCEL_FILE_PATH}
    ${invitations}=    Read Worksheet    header=True
    Close Workbook
    RETURN    ${invitations}

Create PDF file for invitation
    [Arguments]    ${invitation}
    Template Html To Pdf
    ...    ${PDF_TEMPLATE_PATH}
    ...    ${PDF_TEMP_OUTPUT_DIRECTORY}${/}${invitation["first_name"]}_${invitation["last_name"]}.pdf
    ...    ${invitation}

Create ZIP package from PDF files
    ${zip_file_path}=    Set Variable    ${OUTPUT_DIR}${/}PDFs.zip
    Archive Folder With Zip
    ...    ${PDF_TEMP_OUTPUT_DIRECTORY}
    ...    ${zip_file_path}
    RETURN    ${zip_file_path}

Cleanup temporary PDF directory
    Remove Directory    ${PDF_TEMP_OUTPUT_DIRECTORY}    True
