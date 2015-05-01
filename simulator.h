#ifndef SIMULATOR_H_
#define SIMULATOR_H_

#include <iostream>
#include <stdlib.h>
#include <time.h>
#include "group.h"
#include "family.h"

class Simulator
{
public:
    
    Simulator();
    ~Simulator();
    
    static const int MAX_FAMILY=1000000;
    static const int natureBirthPerson = 6; //Max children one could get in one generation
    
    //Below are the possibility of certain events in one generation(e.g. ~30 years)
    //So long as we use rand() to generate random number, we will get an integer
    //ranged from 0 to RAND_MAX, so here we multiply each possibility by RAND_MAX.
    static const int natureMarriage = 0.9 * RAND_MAX;  //Possibility of getting married
    static const int natureBirth = 0.2 * RAND_MAX; //Possibility of having birth  
    static const int natureManBirth = 0.5 * RAND_MAX;  //Possibility of birth of men(e.g. the person born is a man)
    static const int natureDeath = 0.7 * RAND_MAX; //Possibility of death
    static const int natureManDeath = 0.5 * RAND_MAX;  //Possibility of death of men(e.g. the person who dies is a man)
    static const int natureParentsDeath = 0.4 * RAND_MAX;  //Possibility of death of a parent
    
    static const int initalFreeMale  = 50;
    static const int initalFreeFemale  = 50;
    
    void start(int generation);
    int countFamily();
    int countTotalPerson();
    int countFreePeople();
    void output(int generation);
    
private:
    Group* freePeople;  //People who have grown up but have not been married yet
    Family** families;   //Pointer that points to the address array of familes
    int familyCount;
    
    void createFamily();
    void removeFamily(Family* family);    
    void marriage();
    void birth();
    void growUp();
    void death();
};

#endif