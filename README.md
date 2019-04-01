Please read through the below 2 content files
- how-to-prepare-nodejs-environment.txt
- how-to-prepare-python-environment.txt

Scenario
We have several projects where data is streamed into a Linux station from 5 different sensors, each individual
sensor sends data every 2 seconds. As the data is received into the Linux station calculations are preformed, and
the results are sent to a PostgreSQL database on the cloud. With these projects we currently do not have access
to live sensors, but need a way to simulate this incoming data to test our software interfaces.

Objective
Create a program using NodeJS or Python that simulates the above scenario. Generate random clustered data
(within a user inputted/specified mean and standard deviation) coming from X (user inputted/specified) sources
every Y (user inputted/specified) seconds and send it into a Postgres database hosted on AWS (Free-tier) account.
Data in the database should be easily sorted and searched.

Important Notes
- Use of libraries is important. For example, native file reading is more efficient than a library; but using a
library makes the process easier.
- Creating an AWS account and setting up a database is an important part of the test.
- Database structure matters.

