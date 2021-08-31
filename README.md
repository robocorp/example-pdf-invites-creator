# PDF invites creator: multi-task robot example

Starting from an Excel file, this robot will generate a personalized PDF invitation for each participant to an event.

> You can find the full tutorial and instructions on [Robocorp's documentation site](https://robocorp.com/docs/development-guide/pdf/pdf-invites-printer).

This robot demonstrates the advanced features of the Robocorp set of tools:

- Support for multiple tasks inside the same robot
- Using the `Robocorp.WorkItems` library to pass data between two different tasks in Control Room.

Running this robot locally needs some setup steps:

### Setting up the Robocorp.WorkItems library for local use

When executing our robot in a cloud environment like [Control Room](https://cloud.robocorp.com), the `RPA.Robocorp.WorkItems` library will store the work item in the cloud environment, sharing its contents between steps defined in the same process, without any configuration needed.

When developing our robot and running it locally, however, we want the library to store the data in a JSON file, and provide the required parameters to simulate the cloud environment. You can learn more about the internals of the `RPA.Robocorp.WorkItems` library [here](https://robocorp.com/docs/development-guide/control-room/data-pipeline).

To understand how local work items are configured, see the environment variables defined in `devdata/env.json`.

## First task: Excel to Work Item

This robot will:

- download and collect the data from an Excel file
- process the data into the correct format
- add the data to a work item and exit

Get to the code:

[01-excel-to-work-item.robot](./01-excel-to-work-item.robot)

## Second task: work item to PDF

This robot will:

- retrieve the data from a work item
- loop through the data and generate a personalized PDF for each event participant using a template into a temporary folder
- collect all generated files into a zip archive in the output folder
- write log files
- clean up after itself by deleting the temporary folder

Get to the code:

[02-work-item-to-pdf.robot](./02-work-item-to-pdf.robot)

## `robot.yaml` configuration

For this example, the [`robot.yaml`](./robot.yaml) file has been configured to include the two tasks.

In **Robocorp Lab**, you will be able to choose which of the two tasks to run when clicking on the `Run Robot` button.

In **Control Room**, you can select which of the two tasks you want to add to a process as a step.
