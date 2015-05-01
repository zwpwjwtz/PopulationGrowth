#ifndef FAMILY_H_
#define FAMILY_H_

#include "group.h"

class Family
{
public:
    static const int MAX_CHILD=6;
    
    Family();
    ~Family();
    
    void show_state();
    int getPopulation();
    Group* getGroup();
    
    bool bear(bool isMale);
    Group* growUp();
    void dead(bool isMale, bool isParent);
    
private:
    int population; //Total population of the family
    bool father, mother;    //Indicate the existence of parents
    bool* children; //Childrens' sex in bool; here 'true'='male', 'false'='female'
    int childrenCount;  //Population of children
    int lastGrownUp;    //a pointer indicating the last child that have already grown up
};

#endif