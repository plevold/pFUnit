F90 ?= gfortran

I=-I
M=-I
L=-L

FFLAGS += -g -O0 -fbacktrace
FFLAGS += -fbounds-check -fcheck=mem
FFLAGS += -DSTRINGIFY_SIMPLE
FPPFLAGS += -DGNU

# The ramifications across all GNUish configurations of eliding CPPFLAGS here are not known. MLR 2013-1104
CPPFLAGS += -DGNU

ifeq ($(USEOPENMP),YES)
FFLAGS += -fopenmp
LIBS += -lgomp
endif

