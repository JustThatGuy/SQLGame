# Getting started with the SQL Game

This project was created using docker. In order to set up the project, there's a few simple steps to take:

## Cloning the project

The first step is cloning the project and opening it in your code editor. My personal preference goes to Visual Studio Code, but feel free to use anything else!

## Opening the terminal

I'll explain how to open your terminal on Mac, windows, and in VS Code for clarity sake. It's obviously easiest in the code editor itself, but the slightly more tech savvy among you will understand the other terminals as well.

### Mac Terminal

In mac, press the Spotlight Search button (F4, Search Icon), and type in "Terminal". From here, navigate to the location you have stored your project.
I've added mine to the documents folder, so i'll type:
'''
cd documents/sqlgame
'''

### Windows CMD

WIP

### VS Code Integrated Terminal

Inside VS Code, navigate to the "Terminal" section and select "New Terminal". This will open a text field below your normal view(s) in which you can execute commands within the scope of your project. It functions just like any other terminal, it just saves you some navigating.

## Composing the Docker

After you've opened the terminal, you'll want to actually start the game. Instead of running a .exe containing all the viruses I could find, I'll let you execute
'''
docker compose up -d
'''
in the terminal. This will start doing a whole bunch of things, basically installing the game!

## Start playing!!

From here on out it's easy! You can navigate to [localhost:8228](localhost:8228) and start your epic monster slaying journey through SQL!