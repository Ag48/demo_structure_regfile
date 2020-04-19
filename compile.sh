#!/bin/bash -eu

TOP=tb_regfile_2
WD=./work
LIB=$(find lib -name "*.sv")
SRC=$(find src -name "*.sv")
TB=$(find tb -name "*.sv")


vlib ${WD}
vlog ${LIB} ${SRC} ${TB}
vsim -c work.${TOP} -do "run -all"

