#include "simulator.h" 

using namespace std;

Simulator::Simulator()
{
    freePeople=new Group();
    freePeople->male=initalFreeMale;
    freePeople->female=initalFreeFemale;
    
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

void Simulator::start(int generation)
{
    /*
    for (int i=0;i<MAX_FAMILY;i++)
        createFamily();
    for (int i=0;i<MAX_FAMILY;i++)
        removeFamily(families[0]);
    */
    for (int i=1; i<=generation; i++)
    {
        marriage();
        birth();
        growUp();
        death();
        output(i);
    }    
}

void Simulator::createFamily()
{
    Family* tempFamily;
    tempFamily=new Family();
    for(int i=familyCount+1; i!=familyCount; i=(i+1) % MAX_FAMILY) //Try to find an available index
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

void Simulator::marriage()
{
    srand((unsigned)time(NULL));    //Set random seed
    int totalMale = freePeople->male;
    for (int i=0;i<totalMale; i++)
    {
        //Pick a man first
        if (freePeople->female==0) return;   //No chance to have a marriage: either him or left bachelors
        if (rand() < natureMarriage)  //Decided to get married
        {
            createFamily();
            freePeople->male--;
            freePeople->female--;
        }
    }
}

void Simulator::birth()
{
    srand((unsigned)time(NULL));    //Set random seed
    int n;
    int i,j;
    for (i=0; i<MAX_FAMILY; i++)
    {
        if (!families[i]) continue;
        if (rand()<natureBirth)
        {
            n = float(natureBirthPerson) * rand() / RAND_MAX;   //How many children one would get
            for (j=0;j<n;j++)
            {
                families[i]->bear(rand() < natureManBirth); //Get a boy or girl
            }
        }
    }
}

void Simulator::growUp()
{
    Group* tempGroup;
    for (int i=0; i<MAX_FAMILY; i++)
    {
        if (!families[i]) continue;
        tempGroup=families[i]->growUp();
        if (tempGroup)  //The grown-ups from family come into the group of freep people
        {
            freePeople->male += tempGroup->male;
            freePeople->female += tempGroup->female;
        }
    }
}

void Simulator::death()
{
    srand((unsigned)time(NULL));    //Set random seed
    int n;
    int i,j;
    for (i=0; i<MAX_FAMILY; i++)
    {
        if (!families[i]) continue;
        if (rand() < natureParentsDeath)    //One of the parent will die
        {
            families[i]->dead(rand() < natureManDeath, true);   //Father or mother die              
        }
        n=families[i]->countChildren();
        for (j=0; j<n; j++)
        {
            if (rand() < natureDeath)   //Children j in family will die
            {
                families[i]->dead(rand() < natureManDeath, false);   //A boy or girl die              
            }
        }
        if (families[i]->getPopulation()==0) removeFamily(families[i]);   //Familiy disapper
    }
    
    n= freePeople->male + freePeople->female;
    for (i=0; i<n; i++)
    {
        if (rand() < natureDeath)   //Free person i will die
        {
            freePeople->removePerson(rand() < natureManDeath);  //A man or woman die
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
        if (families[i])    count+=families[i]->getPopulation();
    }
    return count;
}

int Simulator::countFreePeople()
{
    return freePeople->male + freePeople->female;
}

void Simulator::output(int generation)    //Print the current status
{
    if (generation==1)   cout<< "Gener." << "\tTotal" << "\tFamily" << "\t Free" << endl;
    cout << generation << "\t" << countTotalPerson() << "\t" << familyCount << "\t " << freePeople->male + freePeople->female << endl;
}