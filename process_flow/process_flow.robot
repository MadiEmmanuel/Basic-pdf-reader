*** Settings ***
Documentation     Read the text contained in PDF files
...               and move files to respective folders
Library           RPA.PDF
Library           RPA.FileSystem
Library           OperatingSystem
Library           String


*** Variables ***
${file1}=       ${CURDIR}/../process_flow/Invoice-DHB.pdf        #Initialize file with path
${file2}=       ${CURDIR}/../process_flow/Xaclty_Invoice.pdf
${invoice_one}=      Set Variable     Invoice                   #Variable to be used to perform checks in pdf
${invoice_two}=     Set Variable      Xaclty

${folder1}=             ${CURDIR}/../Sample_scans               
${folder2}=             ${CURDIR}/../Folder_Names

*** Keywords ***
#Extract text from PDF file into a text file
    #OperatingSystem.Copy File   ${CURDIR}/Xaclty_Invoice.pdf       ${CURDIR}/../Folder_Names

*** Tasks ***
Extract text from PDF files
    ${text}=        Get Text From PDF       ${file1}        #PDF file 
    ${matches}=     Variable Should Exist   ${text}         ${invoice_one}      #Evaluate variable appears in pdf extract
    OperatingSystem.Create Directory      ${CURDIR}/../process_flow/Client_Africa       #Create a directort where extracted file will be save at
    OperatingSystem.Move File   ${CURDIR}/../process_flow/Invoice-DHB.pdf       ${CURDIR}/../process_flow/Client_Africa   #Move file to a desired directory
    ${moved_files}=     Count Items In Directory    ${CURDIR}/../process_flow/Client_Africa         #Count files in the directory
    Set Variable    'Moved'${moved_files} 'number of files'
    

    ${text2}=        Get Text From PDF       ${file2}
    ${matches}=     Variable Should Exist   ${text2}         ${invoice_two}
    OperatingSystem.Create Directory      ${CURDIR}/../process_flow/Xaclty_Client 
    OperatingSystem.Move File   ${CURDIR}/../process_flow/Xaclty_Invoice.pdf      ${CURDIR}/../process_flow/Xaclty_Client
    ${moved_files}=     Count Items In Directory    ${CURDIR}/../process_flow/Xaclty_Client
    Set Variable    'Moved'${moved_files} 'number of files'      
    

    