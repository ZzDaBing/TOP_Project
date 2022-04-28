#Commands
CC=gcc
MPICC=mpicc
RM=rm -f
MAKEDEPEND=makedepend

#flags
CFLAGS=-Wall -g
LDFLAGS=-lm

#Files
LBM_SOURCES=main.c lbm_phys.c lbm_init.c lbm_struct.c lbm_comm.c lbm_config.c
LBM_HEADERS=$(wildcards:*.h)
LBM_OBJECTS=$(LBM_SOURCES:.c=.o)

TARGET=lbm display

CREATEDFILES=resultat.raw output.gif

all: $(TARGET)

%.o: %.c
	$(MPICC) $(CFLAGS) -c -o $@ $<

lbm: $(LBM_OBJECTS)
	$(MPICC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

display: display.c
	$(CC) $(CFLAGS) -o $@ display.c

clean:
	$(RM) $(LBM_OBJECTS)
	$(RM) $(TARGET)
	$(RM) $(CREATEDFILES)

depend:
	$(MAKEDEPEND) -Y. $(LBM_SOURCES) display.c

run:
	mpiexec -n 4 ./lbm

gif:
	bash ./gen_animate_gif.sh resultat.raw output.gif

# check:
# 	./display --checksum ../ref_resultat_200.raw 100
# 	./display --checksum resultat.raw 100
# 	./display --checksum ../ref_resultat_200.raw 199
# 	./display --checksum resultat.raw 199

.PHONY: clean all depend run gif check

# DO NOT DELETE

main.o: lbm_config.h lbm_struct.h lbm_phys.h lbm_comm.h lbm_init.h
lbm_phys.o: lbm_config.h lbm_struct.h lbm_phys.h lbm_comm.h
lbm_init.o: lbm_phys.h lbm_struct.h lbm_config.h lbm_comm.h lbm_init.h
lbm_struct.o: lbm_struct.h lbm_config.h
lbm_comm.o: lbm_comm.h lbm_struct.h lbm_config.h
lbm_config.o: lbm_config.h
display.o: lbm_struct.h lbm_config.h
