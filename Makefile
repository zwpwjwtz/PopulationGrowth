source_file = main.cpp group.cpp family.cpp simulator.cpp
all: $(source_file)
	g++ -Wall $(source_file) -o population

