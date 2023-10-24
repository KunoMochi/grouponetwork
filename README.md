# grouponetwork
OpenClassRoom project - GroupoMania internal social networking site

-------------------------------
Description
-------------------------------

This web app is an internal social networking site created to allow users to post topics and replies within the privacy of the company.

For the backend, the app uses Node.js, Express.js, and MSSQL for Node.js plugin.
For the frontend, Vue.js, Axios, and Moment.js are utilized.

The app also uses SQL Server to manage a relational database for storing data.


-------------------------------
Preparing the SQL Server Database:
-------------------------------

The provided SQL script can be used to generate a new SQL Server database with the necessary tables and stored procedures to be used by the web app.

To run the SQL script, first install Microsoft SQL Server 2022 Express. You can find the official download from the provided address:
https://www.microsoft.com/en-us/download/details.aspx?id=104781

Next, install the Sql Server Management Studio (SSMS). If you chose to use the Basic setup, it should direct you to install SSMS next. Otherwise, you can download the installer here:
https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16

For Mac or Linux users, you can follow the installation instructions from here:
https://builtin.com/software-engineering-perspectives/sql-server-management-studio-mac

Installation options can be left as default. (localhost/SQLEXPRESS, Port: 1433)

After installation, open up Microsoft SQL Server Management Studio and log in with your Windows Authentication, making sure that the "Server Type" is set to "Database Engine".

A new user named GroupDBAdmin needs to be created to establish a connection with the database server. To create a new user, look to the Object Explorer on the left. With the connection open to your local database server, expand the Security folder. Right-click on the Logins folder and select "New Login..."

In the following window, for "Login name" put in "GroupDBAdmin". Select "SQL Server authentication" and for the password, put in "ThisIs@Test". Uncheck "Enforce password policy". Select "GroupDB" as the "Default database"

On the left in "Select a page", click on "User Mapping". Map the account to "GroupDB" and fill in "GroupDBAdmin" as the User and "dbo" as the Default Schema. Click OK down at the bottom to finish creating the account.

Once in, go to File > Open > File then find and select GroupDB.sql. Run the script to generate the GroupDB database.

The SQL Server database should now be fully set up for the web app to use.