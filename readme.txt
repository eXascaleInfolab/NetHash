A fixed version of the NetHash algorithm from IJCAI 2018, several small networks and primes used for hashing functions.
The algorithm embeds each node into the $l_1$ (hamming) space.

Comparing to the [original repository](https://github.com/williamweiwu/williamweiwu.github.io), this one contains only the NetHash algorithm and [fixes](https://github.com/williamweiwu/williamweiwu.github.io/pull/2/commits) it's crash on start (SIGSEGV error) caused by exessive allocation of the stack memory (large datasets are dynamically allocated on the heap).

If you use our algorithm and data sets in your research, please cite the following paper as reference in your publicaions:

@inproceedings{wu2018efficient,
  title     = {{E}fficient {A}ttributed {N}etwork {E}mbedding via {R}ecursive {R}andomized {H}ashing},
  author    = {Wei Wu and Bin Li and Ling Chen and Chengqi Zhang},
  booktitle = {IJCAI-18},          
  pages     = {2861--2867},
  year      = {2018}
}

Requirements:
On Ubuntu/Debian Linux, the required libraries can be installed via:
$ sudo apt-get install libboost-dev libgsl-dev

Compilation:
$ g++ -std=c++11 -lm -O3 -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result nethash.cpp -o nethash -lgsl -lm -lgslcblas

Execution:
$ ./nethash -network nets/dblp.adjlist -feature nets/dblp.adjlist -hashdim 128 -depth 2 -degreeentropy 2.47 -embedding dblp_d2_e2.47_128.emb -time dblp_d2_e2.47_128.time 2> dblp_d2_e2.47_128.err 1> dblp_d2_e2.47_128.log
 
