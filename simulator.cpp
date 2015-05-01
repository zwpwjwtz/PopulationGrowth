#include "simulator.h" 
#include <iostream>

using namespace std;

Simulator::Simulator()
{
    freePeople=new Group();
    
    families=new Family*[MAX_FAMILY];
    for(int i=0;i<MAX_FAMILY;i++)
    {
        families[i]=NULL;
    }
    familyCount=0;
}

Simulator::~Simulator()
{
    delete freePeople;
    
    for(int i=0;i<MAX_FAMILY;i++)
    {
        if (families[i]) delete families[i];
    }
}

void Simulator::start()
{
    /*
    for (int i=0;i<MAX_FAMILY;i++)
        createFamily();
    for (int i=0;i<MAX_FAMILY;i++)
        removeFamily(families[0]);
    */
    
}

void Simulator::createFamily()
{
    Family* tempFamily;
    tempFamily=new Family();
    for(int i=familyCount+1; i==familyCount; i=(i+1) % MAX_FAMILY) //Try to find a available index
    {
        if (families[i]==NULL)
        {
            families[i]=tempFamily;
            familyCount++;
            break;
        }
    }
}
void Simulator::removeFamily(Family* family)
{
    for(int i=0;i<MAX_FAMILY;i++)
    {
        if (families[i]==family)
        {
            families[i]=NULL;
            familyCount--;
            break;
        }
    }
}

int Simulator::countFamily()
{
    return familyCount;
}

int Simulator::countTotalPerson()
{
    int count = freePeople->male + freePeople->female;
    for (int i=0;i<MAX_FAMILY;i++)
    {
        count+=families[i]->getPopulation();
    }
    return count;
}

int Simulator::countFreePeople()
{
    return freePeople->male + freePeople->female;
}

void Simulator::output()    //Print the current status
{
    cout << "Total:" << countTotalPerson() << "\tFamilies:" << countFamily() << endl;
}