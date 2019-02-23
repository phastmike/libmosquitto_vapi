SRCDIR = src
VAPIDIR = vapi
PACKAGES = --pkg libmosquitto

all:
	# Generate C source code 
	valac -C --vapidir ${VAPIDIR} ${SRCDIR}/example_sub.vala ${PACKAGES} 
	valac -o ${SRCDIR}/example_sub --vapidir ${VAPIDIR} ${SRCDIR}/example_sub.vala ${PACKAGES} 

test:
	# Generate C source code 
	valac -C --vapidir ${VAPIDIR} ${SRCDIR}/test.vala ${PACKAGES} 
	valac -o ${SRCDIR}/test --vapidir ${VAPIDIR} ${SRCDIR}/test.vala ${PACKAGES} 

clean:
	rm ${SRCDIR}/test
	rm ${SRCDIR}/example_sub

cleanccode:
	rm ${SRCDIR}/test.c
	rm ${SRCDIR}/example_sub.c
