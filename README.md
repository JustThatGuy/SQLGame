# Getting started with the SQL Game
This project was created using docker. In order to set up the project, there's a few simple steps to take:

## 001 // Cloning the project
The first step is cloning the project from here and opening it in your code editor. My personal preference goes to Visual Studio Code, but feel free to use anything else! Just be sure to run proper version management in case we decide to patch the game in the future, or you'd like to fork it to help us out.

## 002 // Opening the terminal
I'll explain how to open your terminal on Mac, windows, and in VS Code for clarity sake. It's obviously easiest in the code editor itself, but the slightly more tech savvy among you will understand the other terminals as well (if you're not already long past reading this).

  ### 002.1 // Mac Terminal
  On mac, press the Spotlight Search button (F4, Search Icon), and type in "Terminal". From here, navigate to the location you have stored your project.
  I've added mine to the documents folder, so i'll type `cd documents/sqlgame` and press the return key so i'm ready to compose my docker.

  ### 002.2 // Windows CMD
  Luckily for the few guys who couldn't let go of Bill Gates' hand, using CMD is practically identical to the guys on Mac that need to show you. I'm kidding, I use windows at home   too. Anyway, you'll want to open up Command Prompt and use `cd your\file\path` to navigate to wherever you've put your project folder. Once you're there, you can move on to        composing the docker.

  ### 002.3 // VS Code Integrated Terminal
  Inside VS Code, navigate to the "Terminal" section and select "New Terminal". This will open a text field below your normal view(s) in which you can execute commands within the   scope of your project. It functions just like any other terminal, it just saves you some navigating. Once this is open, you're ready for the next step!

## 003 // Composing the Docker
After you've opened the terminal, you'll want to actually install the game. Instead of running a .exe containing all the viruses I could find, I'll let you execute
`docker compose up -d` in the terminal. This will start doing a whole bunch of things, don't worry too much. Ordina doesn't have to know.

## 004 // Start playing!!
From here on out it's easy! You can navigate to [localhost:8228](localhost:8228) and start your epic monster slaying journey through SQL!
