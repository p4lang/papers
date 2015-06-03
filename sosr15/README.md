Instructions to reproduce results from SOSR 2015 paper:

DC.p4: Programming the Forwarding Plane of a Data-Center Switch

0. sudo apt-get install git make
1. git clone https://github.com/p4lang/papers/
2. git clone https://github.com/p4lang/p4factory/
3. cd p4factory
4. git checkout 3b0de0136faf3c8fe3a969f5488054b7a91f3568
5. # Follow the instructions in p4factory/README.md to install the P4 compiler and software switch
6. cd targets
7. ../tools/newtarget.py DC
8. cp -r ../../papers/sosr15/DC.p4/* DC/p4src
9. cd DC
10. make

The instructions above were tested on an Ubuntu 14.04 EC2 instance.

They create a p4 target in the same vein as targets in https://github.com/p4lang/p4factory/

If something doesn't work, please send an email to anirudh@csail.mit.edu
