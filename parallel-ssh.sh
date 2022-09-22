#Run the following command to start simultaneous ping test using iperf3 

parallel-ssh -h <text file which parallel-ssh reads the hosts names out of> -i -- bash iperf3_client.sh 
