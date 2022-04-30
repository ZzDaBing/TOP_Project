# TOP_Project

Compiling project:
make

Run project: /!\ nb_processes must be pair /!\
OMP_NUM_THREADS=<nb_threads> mpiexec -np <nb_processes> ./lbm
(make run <- runs the code with 1 thread and 4 processes)

Creating gif:
make gif

