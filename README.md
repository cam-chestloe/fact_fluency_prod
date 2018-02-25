CSS Classes:
    - main-wrapper:
        - Grid container
        - 12 col
        - auto rows
    - card-hover:
        - shadows
        - shadow hover effects


To compile on windows.
- Open the cmd prompt as administrator
- navigate to the fact fluency root folder
- run the command:
    cmd /K "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64



Student Test Page In Test Page Folder 
- Remove blue outline when buttons are focused
- Toggle keyboard when pressed
    - 1st time = display right
    - 2nd time = display center
    - 3rd time = display left
    - 4th time = hide
- Keyboard buttons when pressed type
- Input feild automatically has cursor ready to type
- Input Feild only allows numbers
- Toggle start button to remove card-ready-set-go
    - Wait 3 seconds before starting the test
- Link all the buttons and cancels to proper places
-Problem solve navbar sitting on top but remaining transparent



Teacher Class Page in Teacher Page Folder
- Add Class button creates a card
- Add class button always sits at the end of list


Fritz's TODO:
- Create tests for test_parameters:
    - Validate distill_parameters
    - Validate student_params
- Validate test parameters when creating a new test. The test params should be complete after running "create_test_parameters()".
- Randomize the display of questions while taking tests.
- Add a "submit" step at the end of taking a test.