#ifndef SIMULATOR_H_
#define SIMULATOR_H_

#include "group.h"
#include "family.h"

class Simulator
{
public:
    
    Simulator();
    ~Simulator();
    
    static const int MAX_FAMILY=1000000;
    
    void start();
    int countFamily();
    int countTotalPerson();
    int countFreePeople();
    void output();
    
private:
    Group* freePeople;  //People who have grown up but have not been married yet
    Family** families;   //Pointer that points to the address array of familes
    int familyCount;
    
    void createFamily();
    void removeFamily(Family* family);    
};

#endif