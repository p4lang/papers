These instructions exist for archival purposes. A more recent version of this program, switch.p4, with more features is available at: https://github.com/p4lang/switch.

Instructions to reproduce results from SOSR 2015 paper 

DC.p4: Programming the Forwarding Plane of a Data-Center Switch

(The below instructions were tested on a fresh Ubuntu 14.04 EC2 instance)

(Assume we start at the home directory ~)

0. sudo apt-get install git make
1. git clone https://github.com/p4lang/papers/
2. git clone https://github.com/p4lang/p4factory/
3. cd ~/p4factory
4. git checkout sosr-dc-p4
5. # Follow the instructions in https://github.com/p4lang/p4factory/#quickstart  to install the P4 development environment
6. cd ~/p4factory/targets
7. ~/p4factory/tools/newtarget.py DC
8. cp -r ~/papers/sosr15/DC.p4/* ~/p4factory/targets/DC/p4src
9. cd ~/p4factory/targets/DC/
10. make # To compile executable version of DC.p4
11. sudo ./behavioral-model # To run it
12. sudo python run_tests.py --test-dir of-tests/tests/ # Simple echo test using run-time API; run in a different terminal

If something doesn't work, please email me at anirudh@csail.mit.edu
