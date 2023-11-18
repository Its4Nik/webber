Webber Script
Overview
Welcome to Webber, a bash script designed to help you manage and create web content from Markdown files. Webber simplifies the process of creating an index page and individual post pages for your website or blog.

Table of Contents
Features
Getting Started
Usage
Configuration
Uninstallation
Author
Features
Setup: Initialize or renew your configuration easily.
Overview Page: Automatically generate an index page for your website.
Post Processing: Convert Markdown files into individual post pages.
Flexible Configuration: Easily customize input and output directories.
Getting Started
Clone the Webber repository to your local machine.

bash
Copy code
git clone https://github.com/itsnik/Webber.git
cd Webber
Make the script executable.

bash
Copy code
chmod +x webber.sh
Run the initial setup to configure input and output directories.

bash
Copy code
./webber.sh
Usage
After the initial setup, Webber provides a simple interface to perform various actions:

Press q to save and quit.
Press c to exit without saving.
Press s to save and continue.
Press r to redo the setup.
Press u to uninstall Webber.
Configuration
Webber uses a configuration file (.env) to store input and output directories. You can customize these directories by running:

bash
Copy code
./webber.sh --renew
Follow the prompts to enter the absolute paths for input and output directories.

Uninstallation
To uninstall Webber, run the following command:

bash
Copy code
./webber.sh -u
Follow the prompts to confirm the uninstallation.

Author
Webber is created and maintained by ItsNik. Feel free to reach out for any questions or feedback.

Thank you for using Webber! If you encounter any issues or have suggestions for improvement, please open an issue on the GitHub repository.
