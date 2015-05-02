#include "group.h"

Group::Group()
{
    male=0;
    female=0;
}

Group::~Group()
{
}
    
float Group::getRatio()
{
    return float(male)/female;
}

void Group::addPerson(bool isMale)
{
    if (isMale) male++; else female++;
}

void Group::removePerson(bool isMale)
{
    if (isMale && male>0) male--;
    else if (female>0) female--;
}