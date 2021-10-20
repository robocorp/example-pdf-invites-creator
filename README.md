# PDF invites creator robot

This robot will generate a personalized PDF invitation for each participant to an event starting from an Excel file.

> You can find the full tutorial and instructions on [Robocorp's documentation site](https://robocorp.com/docs/development-guide/pdf/pdf-invites-printer).

This robot will:

- download and collect the data from an Excel file
- process the data into the correct format
- loop through the data and generate a personalized PDF for each event participant using a template into a temporary folder
- collect all generated files into a zip archive in the output folder
- write log files
- clean up after itself by deleting the temporary folder
