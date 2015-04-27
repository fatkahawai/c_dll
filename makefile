#
# Makefile
#
# Copyright (C) Pink Pelican NZ Ltd 2015
#
# No rights reserved
# You may treat this program as if it was in the public domain
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# Keep things simple for novice users
# so do not use any implicit rules!
#

all : test

clean :
	rm *.o *.a *.so *.so.1 *.so.1.0 test

test : test.o libmylib.so.1
	gcc -Wall -L. test.c -lmylib -o test
#	gcc -o test test.o halve.o ;\
#	chmod +x test ;\
	export LD_LIBRARY_PATH=.
	./test

libmylib.so.1 : libmylib.so
	ln -sf libmylib.so.1.0 libmylib.so.1

libmylib.so : libmylib.so.1.0
	ln -sf libmylib.so.1.0 libmylib.so

libmylib.so.1.0 : halve.o 
	gcc -shared -Wl,-soname,libmylib.so.1 -o libmylib.so.1.0 halve.o

# The next lines generate the various object files

halve.o : halve.c halve.h
	gcc -Wall -fPIC -c halve.c 


test.o : test.c halve.h
	gcc -c test.c
