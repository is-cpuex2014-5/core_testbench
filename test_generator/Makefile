CXX = g++
SRCS = eq.cpp lt.cpp add.cpp sub.cpp not.cpp and.cpp nand.cpp nor.cpp or.cpp xor.cpp right_arith_shift.cpp left_arith_shift.cpp right_logic_shift.cpp left_logic_shift.cpp
OBJS = $(SRCS:.cpp=.o)
DEPS = $(OBJS:.o=.d)
CXXFLAGS = -std=c++11 -O3 -g -I.. -I../src
LDFLAGS =
TESTS = $(SRCS:.cpp=)

all: $(OBJS) $(DEPS) $(TESTS)
	./gen.sh

%.o:%.cpp %.d
	$(CXX) -c $(CXXFLAGS) -o $@ $<

%.d:%.cpp
	rm -f $@
	$(CXX) -c -MM $(CXXFLAGS) $< > $@

clean:
	rm -f $(OBJS) $(DEPS) $(TESTS)

check-syntax:
	$(CXX) $(CXXFLAGS) -fsyntax-only $(CHK_SOURCES)

%: %.o
	$(CXX) -o $@ $^ $(LDFLAGS)

.PHONY:all clean check-syntax 

-include $(DEPS)
