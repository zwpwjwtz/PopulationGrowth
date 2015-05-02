#include "family.h"
#include <iostream>

using namespace std;

Family::Family()
{
    population=2;
    father=true;
    mother=true;
    children=new bool[MAX_CHILD];
    childrenCount=0;
    lastGrownUp=0;
    totalChildren=0;
}

Family::~Family()
{
    delete children;
}

void Family::show_state()
{
    cout << "Father:" << father << " Mother: " << mother << " Population: " << population << endl;
}

int Family::getPopulation(bool includeGrownUp)
{
    if (includeGrownUp)
        return population;
    else
        return population - lastGrownUp;
}

int Family::countChildren(bool total)
{
    if (total)
        return totalChildren;
    else
        return childrenCount;
}

Group* Family::getGroup(bool includeGrownUp)
{
    Group* tempGroup=new Group;
    if (childrenCount>0)
    {
        if (includeGrownUp)
        for (int i=0;i<childrenCount;i++)
        {
            tempGroup->addPerson(children[i]);
        }
        else
        for (int i=lastGrownUp;i<childrenCount;i++)
        {
            tempGroup->addPerson(children[i]);
        }
    }
    if (father) tempGroup->addPerson(true);
    if (mother) tempGroup->addPerson(false);
    return tempGroup;
}

bool Family::bear(bool isMale)
{
    if (!(father && mother)) return false;
    if (childrenCount >= MAX_CHILD) return false;
    population++;
    children[childrenCount++]=isMale;
    totalChildren++;
    return true;
}

Group* Family::growUp()  //Get the grown-ups of this generation
{
    if (childrenCount==0 || childrenCount<= lastGrownUp) return NULL;
    Group* tempGroup=new Group;
    for (int i=0;i<childrenCount;i++)
    {
        tempGroup->addPerson(children[i]);
    }
    lastGrownUp=childrenCount;
    return tempGroup;
}

void Family::dead(bool isMale, bool isParent)
{
    if (isParent)
    {
        if (isMale && father)
        {
            father=false;
            population--;
        }
        else if (mother)
        {
            mother=false;
            population--;
        }
    }
    else
    {
        if (childrenCount>0)
        {
            for (int i=lastGrownUp;i<childrenCount;i++) //Exclude children who have already grown up
            {
                if (children[i]==isMale)
                {                    
                    for(int j=i;j<childrenCount;j++)    //Move all the children behind i forward by 1 
                    {
                        children[j]=children[j+1];
                    }
                    if (i<lastGrownUp && i>0) lastGrownUp--;   //Adjust pointer lastGrownUp
                    childrenCount--;
                    population--;
                    break;
                }
            }
        }  
    }
}