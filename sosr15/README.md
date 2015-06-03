Instructions to reproduce results from SOSR 2015 paper:

DC.p4: Programming the Forwarding Plane of a Data-Center Switch

0. sudo apt-get install git
1. git clone https://github.com/p4lang/papers/
2. git clone https://github.com/p4lang/p4factory/
3. cd p4factory
4. git checkout 3b0de0136faf3c8fe3a969f5488054b7a91f3568 # These instructions were tested against that particular commit.
5. # Follow the instructions in README.md at https://github.com/p4lang/p4factory/ to install the P4 compiler, run-time environment, and software switch
6. cd targets
7. ../tools/newtarget.py DC # Creates a new target based on instructions here: https://github.com/p4lang/p4factory#creating-a-new-target
8. cp -r ../../papers/sosr15/DC.p4/* DC/
9. make # Compiles the P4 program into an executable

The instructions above were tested on an Ubuntu 14.04 EC2 instance.
They create a p4 target in the same vein as targets in https://github.com/p4lang/p4factory/
