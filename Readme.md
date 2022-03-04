## Docker deployment demo to AppService
This script will pack and automatically deploy any docker project that exists in working directory.
# Way #1
1. Install az cli
1. Put script to repo root
1. Run az login in Terminal
1. Run the script with paramenters like `./DeployWindows.ps1 -Sufix 1 -PlanSize S2 -DockerInstanceNo 6`
1. Enjoy!

# Way #2
Just run action and enjoy
It will ask to login into Azure in the middle, so don't forget to review logs.