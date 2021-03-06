ifeq ($(USEOPENMP),YES)
F90 ?= xlf2003
else
F90 ?= xlf2003_r
endif

D=-WF,-D
I=-I
M=-I
L=-L

FFLAGS += -g -O0 -WF,-qfpp -C

ifeq ($(USEOPENMP),YES)
FFLAGS += -qsmp=omp
endif

FPPFLAGS := $(FPPFLAGS:-D%=$D%)
CPPFLAGS := $(CPPFLAGS:-D%=$D%)
FPPFLAGS += $DSTRINGIFY_SIMPLE $DIBM
CPPFLAGS += -WF,-DSTRINGIFY_SIMPLE,-DIBM
