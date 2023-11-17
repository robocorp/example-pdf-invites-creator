# PDF invites creator task package

This automation will generate a personalized PDF invitation for each participant to an
event starting with an Excel file holding the table with the invitations.

> You can find the full tutorial and instructions on
> [Robocorp's documentation site](https://robocorp.com/docs/development-guide/pdf/pdf-invites-printer).

You have two tasks, where both are doing the same thing, but in different flavors:
- `Robot Framework - Create PDF invitations`
- `Python - Create PDF invitations`


1. Download and collect the data from an Excel file.
2. Process the data into the correct format.
3. Loop through the data and generate a personalized PDF for each event participant
   using a template into a temporary output folder.
4. Collect all the generated files into a zip archive in the output folder.
5. Write log files about what happened.
6. Clean up leftovers.
