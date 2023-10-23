*** Settings ***
Documentation       Playwright template.

Library             RPA.Browser.Playwright
Library             OperatingSystem

*** Variables ***
${URL}              https://portal.icaniotech.com/
${EMAIL}            youremail@gmail.com
${PASSWORD}         Password
${SigninButtonXpath}    xpath=/html/body/div[1]/div[1]/div/section/div/div/div/div/div[1]/div/div/div/div[1]/div[2]/div/div[2]/div/div/div/section/div/div/div/form[2]/button
${SigninNextButton}      xpath=/html/body/div[1]/div[1]/div[2]/div/c-wiz/div/div[2]/div/div[2]/div/div[1]/div/div/button
${EmailNextButton}      xpath=/html/body/div[1]/div[1]/div[2]/div/c-wiz/div/div[2]/div/div[2]/div/div[1]/div/div/button
${PasswordNextButton}   xpath=/html/body/div[1]/div[1]/div[2]/div/c-wiz/div/div[2]/div/div[2]/div/div[1]/div/div/button
${GoogleButtonXpath}    xpath=//*[@id='_google_GoogleLoginPortlet_INSTANCE_pdls_openidconnectform']/button
${EmailInputId}         xpath=/html/body/div[1]/div[1]/div[2]/div/c-wiz/div/div[2]/div/div[1]/div/form/span/section/div/div/div[1]/div/div[1]/div/div[1]/input
${PasswordInputName}    xpath=/html/body/div[1]/div[1]/div[2]/div/c-wiz/div/div[2]/div/div[1]/div/form/span/section[2]/div/div/div[1]/div[1]/div/div/div/div/div[1]/div/div[1]/input
${TimeSheetButton}      xpath=/html/body/div[1]/div[1]/div/section/div/div[2]/div[1]/div/div/div/div/div/div/div/section/div/div[2]/div/div/ul/li[4]/a
${CheckInButton}        xpath=/html/body/div[1]/div[1]/div/section/div/div[2]/div[2]/div/div/div/div/div/div/section/div/div[2]/div/div[1]/div/div[2]/form/div/button
${TimeSheetButton2}      xpath=toggle-btn
${TIMESHEET_URL}        xpath=https://portal.icaniotech.com/web/portals/time-sheet
*** Tasks ***
Minimal task
    New Browser     headless=${False}  # starts in headless in Control Room
    New Page       ${URL}
    Sleep           5 seconds
    Wait For Elements State    ${SigninNextButton}    visible
    Click   ${SigninNextButton}
    Wait For Elements State    ${EmailInputId}    visible
    Type Text   ${EmailInputId}    ${EMAIL}
    Click   ${SigninNextButton}
    Sleep           2 seconds
    Wait For Elements State    ${PasswordInputName}    visible
    Type Text  ${PasswordInputName}    ${PASSWORD}
    Click   ${SigninNextButton}
    Sleep   20 seconds
    New Page  https://portal.icaniotech.com/web/portals/time-sheet
    Sleep           2 seconds
     # Check-out
    Wait For Elements State    id:${TimeSheetButton2}    visible
    ${checkOut} =    Get Text    id:${TimeSheetButton2}    
    Run Keyword If    "Check - Out" in ${checkOut}    Log    Checkout Successfully
    Run Keyword Unless  "Check - in" in ${checkOut}     Log    Check in successfully

    # Wait for 30 seconds
    Sleep   30 seconds

    Click   ${TimeSheetButton}
    Sleep           60 seconds

    # Close browsers when done
    Close Browser
