#!/bin/bash

# Change to your project directory where the package.json file is located
cd /path/to/your/project

# Function to display a colored menu option
show_option() {
  echo -e "\e[1;32m$1\e[0m - $2"
}

# Function to display a colored header
show_header() {
  echo -e "\e[3;35m$1\e[0m"
}

# Function to display a colored header
show_output() {
  echo -e " => \e[3;30m$1\e[0m"
}

# Function to get the project name from the Git repository URL
get_project_name() {
  repo_url=$(git config --get remote.origin.url)
  repo_name=$(basename -s .git "$repo_url")
  echo "$repo_name"
}

# Function to open a browser
open_browser_home() {
  start "http://localhost:3333"
  # read -p "Enter the localhost:port to open in the browser (e.g., localhost:3333): " localhost_port
  # start "http://localhost:$localhost_port"
}

# Function to open a browser
open_browser_studio() {
  start "http://localhost:3333/studio"
}

# Get the project name
project_name=$(get_project_name)

# Main loop
while true; do
  # Clear the screen
  clear
  
  # Display the menu
  show_header "------------------------------------------------------------"
  show_header "           Project: $project_name"
  show_header "------------------------------------------------------------"
  show_option "1" "\e[0;34mProject:\e[0m \e[1;32mRun yarn dev\e[0m"
  show_option "2" "\e[0;34mProject:\e[0m \e[1;35mRun yarn build\e[0m"
  show_header "------------------------------------------------------------"
  show_option "3" "\e[0;36mGit Repo:\e[0m \e[1;34mCommit to local\e[0m"
  show_option "4" "\e[0;36mGit Repo:\e[0m \e[1;32mPush to remote\e[0m"
  show_option "5" "\e[0;36mGit Repo:\e[0m \e[1;33mCommit & push to remote\e[0m"
  show_header "------------------------------------------------------------"
  show_option "6" "\e[0;34mOpen a browser:\e[0m \e[1;35mHOME\e[0m"
  show_option "7" "\e[0;34mOpen a browser:\e[0m \e[1;36mSTUDIO\e[0m"
  show_option "8" "\e[1;31mQuit\e[0m"
  show_header "------------------------------------------------------------"
  echo -e "\n"

  # Prompt the user for input
  read -p "Enter your choice (1, 2, 3, 4, 5, 6, or 8): " option

  echo -e "\n"

  # Check the user's input and run the corresponding command
  case "$option" in
    "1")
      yarn dev
      ;;
    "2")
      yarn build
      ;;
    "3")
      read -p "Enter your commit message: " commit_message
      git commit -m "$commit_message"
      ;;
    "4")
      git push
      ;;
    "5")
      read -p "Enter your commit message: " commit_message
      git commit -m "$commit_message"
      git push
      ;;
    "6")
      open_browser_home
      show_output "Opened browser to HOME"
      ;;
    "7")
      open_browser_studio
      show_output "Opened browser to STUDIO"
      ;;
    "8")
      break  # Quit the main loop
      ;;
    *)
      echo "Invalid option. Please select 1, 2, 3, 4, 5, or 6."
      ;;
  esac
  #  Show two empty lines
  echo -e "\n"

  # Wait for Enter key to be pressed before continuing
  read -p "Press Enter to continue..."
done