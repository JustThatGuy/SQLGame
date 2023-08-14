# Getting started with the SQL Game
This project was created using docker. In order to set up the project, there's a few simple steps to take:

## Cloning the project // 001
The first step is cloning the project from here and opening it in your code editor. My personal preference goes to Visual Studio Code, but feel free to use anything else! Just be sure to run proper version management in case we decide to patch the game in the future, or you'd like to fork it to help us out.

## Opening the terminal // 002
I'll explain how to open your terminal on Mac, windows, and in VS Code for clarity sake. It's obviously easiest in the code editor itself, but the slightly more tech savvy among you will understand the other terminals as well (if you're not already long past reading this).

### Mac Terminal // 002.1
In mac, press the Spotlight Search button (F4, Search Icon), and type in "Terminal". From here, navigate to the location you have stored your project.
I've added mine to the documents folder, so i'll type `cd documents/sqlgame` and press the return key so i'm ready to compose my docker.

### Windows CMD // 002.2
WIP

### VS Code Integrated Terminal // 002.3
Inside VS Code, navigate to the "Terminal" section and select "New Terminal". This will open a text field below your normal view(s) in which you can execute commands within the scope of your project. It functions just like any other terminal, it just saves you some navigating. Once this is open, you're ready for the next step!

## Composing the Docker // 003
After you've opened the terminal, you'll want to actually install the game. Instead of running a .exe containing all the viruses I could find, I'll let you execute
`docker compose up -d` in the terminal. This will start doing a whole bunch of things, don't worry too much. Ordina sysadmins don't have to know.

## Start playing!! // 004
From here on out it's easy! You can navigate to [localhost:8228](localhost:8228) and start your epic monster slaying journey through SQL!
