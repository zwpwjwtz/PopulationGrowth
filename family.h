#include "group.h"

class family
{
public:
    static const int MAX_CHILD=6;
    
    family();
    ~family();
    
    void show_state();
    int getPopulation();
    group* getGroup();
    
    bool bear(bool isMale);
    group* growUp();
    void dead(bool isMale, bool isParent);
    
private:
    int population; //Total population of the family
    bool father, mother;    //Indicate the existence of parents
    bool* children; //Childrens' sex in bool    
    int lastGrownUp;    //a pointer indicating the last child that have already grown up
};